//
//  URLRequest+Encoding.swift
//  Network
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import Alamofire

extension URLRequest {
    func encoded(_ parameters: Alamofire.Parameters,
                 encoding: Alamofire.ParameterEncoding) throws -> URLRequest {
        do {
            return try encoding.encode(self, with: parameters)
        } catch {
            throw NetworkError.parametersEncoding(error)
        }
    }

    func encoded(for target: RequestConvertible) throws -> URLRequest {
        switch target.task {
        case .requestData(let body):
            with(self) { $0.httpBody = body }
        case .requestCompositeData(let body, let urlParameters):
            try with(self) { $0.httpBody = body }
                .encoded(urlParameters, encoding: URLEncoding.default)
        case .requestCompositeParameters(_, _, let urlParameters):
            try encoded(urlParameters, encoding: URLEncoding.default)
        case .uploadCompositeMultipart(let urlParameters, _):
            try encoded(urlParameters, encoding: URLEncoding.default)
        case .downloadParameters(let parameters, let encoding, _):
            try encoded(parameters, encoding: encoding)
        default:
            self
        }
    }
}
