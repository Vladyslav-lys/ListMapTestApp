//
//  API+Maps.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 05.03.2025.
//

import Alamofire

extension API {
    public enum Maps: RequestConvertible {
        case downloadMap(params: [String: Any], destination: Network.DownloadDestination)
        
        public var path: String {
            switch self {
            case .downloadMap: "download"
            }
        }
        
        public var task: Network.Task {
            switch self {
            case .downloadMap(let params, let destination):
                    .downloadParameters(parameters: params, encoding: URLEncoding.default, destination: destination)
            }
        }
    }
}
