//
//  Network.swift
//  Network
//
//  Created by Vladyslav Lysenko on 21.02.2025.
//

import Alamofire

final public class Network {
    public typealias ResponseResult = Result<Response, Error>
    public typealias Request = Alamofire.Request
    public typealias Completion = (ResponseResult) -> Void
    public typealias DownloadDestination = DownloadRequest.Destination
    public typealias RequestProgress = (Progress) -> Void
    public typealias Method = Alamofire.HTTPMethod
    public typealias MultipartFormDataBuilder = (MultipartFormData) -> Void
    public typealias Header = HTTPHeader
    public typealias Headers = HTTPHeaders
    
    private let session: Alamofire.Session
    private let baseURL: URL
    private let plugins: [NetworkPlugin]
    private var isInternetAvailable: Bool {
        NetworkReachabilityManager(host: baseURL.absoluteString)?.isReachable == true
    }

    // MARK: - Public
    public init(baseURL: URL, plugins: [NetworkPlugin] = []) {
        self.baseURL = baseURL
        self.plugins = plugins
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        session = Alamofire.Session(
            configuration: configuration,
            startRequestsImmediately: false
        )
    }
    
    public class func suggestedDownloadDestination(name: String,
                                                   for directory: FileManager.SearchPathDirectory = .documentDirectory,
                                                   in domain: FileManager.SearchPathDomainMask = .userDomainMask,
                                                   options: DownloadRequest.Options = [.removePreviousFile, .createIntermediateDirectories]) -> DownloadDestination {
        { temporaryURL, _ in
            let directoryURLs = FileManager.default.urls(for: directory, in: domain)
            let url = directoryURLs.first?.appendingPathComponent(name) ?? temporaryURL
            return (url, options)
        }
    }

    func request(
        _ target: RequestConvertible,
        qos: DispatchQoS.QoSClass = .default,
        progress: ((Int64, Int64) -> Void)? = nil,
        completion: @escaping Completion
    ) -> Request? {
        performRequest(
            CachedRequestConvertible(target),
            queue: .global(qos: qos),
            progress: progress,
            completion: completion
        )
    }

    // MARK: - Private
    private func performRequest(
        _ target: RequestConvertible,
        queue: DispatchQueue,
        progress: ((Int64, Int64) -> Void)? = nil,
        completion: @escaping Completion
    ) -> Request? {
        let commonCompletion: Completion = { result in
            completion(result)
        }

        do {
            let urlRequest = try makeURLRequest(for: target)
            switch target.task {
            case .downloadDestination(let destination), .downloadParameters(_, _, let destination):
                return performDownload(
                    urlRequest,
                    destination: destination,
                    queue: queue,
                    target: target,
                    progress: progress,
                    completion: commonCompletion
                )
            default:
                return performData(
                    urlRequest,
                    queue: queue,
                    target: target,
                    completion: commonCompletion
                )
            }
        } catch {
            queue.async {
                commonCompletion(.failure(error))
            }
            return nil
        }
    }

    // MARK: - Data request
    private func performData(
        _ request: URLRequest,
        queue: DispatchQueue,
        target: RequestConvertible,
        completion: @escaping Completion
    ) -> Request {
        let task = session
            .request(request)
            .responseData(queue: queue) { responseData in
                guard let response = responseData.response, responseData.error == nil else {
                  return completion(.failure(self.performError(responseData.error)))
                }
                completion(Result { Response(data: responseData.data ?? Data(), response: response) })
            }
        task.resume()
        return task
    }

    // MARK: - Download request
    private func performDownload(
        _ request: URLRequest,
        destination: DownloadDestination?,
        queue: DispatchQueue,
        target: RequestConvertible,
        progress: ((Int64, Int64) -> Void)?,
        completion: @escaping Completion
    ) -> Request {
        let task = session
            .download(request, to: destination)
            .downloadProgress(closure: {
                progress?($0.totalUnitCount, $0.completedUnitCount)
            })
            .responseData(queue: queue) { responseData in
                guard let data = responseData.value,
                      let response = responseData.response,
                      responseData.error == nil else {
                    return completion(.failure(self.performError(responseData.error)))
                }
                completion(Result { Response(data: data, response: response) })
            }
        task.resume()
        return task
    }

    // MARK: - URLRequest builder
    private func makeBaseURL(for target: RequestConvertible) throws -> URL {
        target.baseURL ?? baseURL
    }

    private func makeURLRequest(for target: RequestConvertible) throws -> URLRequest {
        let url = try makeBaseURL(for: target)
            .appendingPathComponent(target.path)
        var request = try URLRequest(url: url).encoded(for: target)
        request.httpMethod = target.method?.rawValue
        target.headers?.dictionary.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return try prepare(request, target: target)
    }

    // MARK: - Perform error
    private func performError(_ error: Error?) -> NetworkError {
        isInternetAvailable ? NetworkError(error) : NetworkError.noInternetConnection
    }
}

// MARK: - Handle NetworkPlugin methods
extension Network {
    private func prepare(_ request: URLRequest, target: RequestConvertible) throws -> URLRequest {
        try plugins.reduce(request) { try $1.prepare($0, target: target) }
    }
}
