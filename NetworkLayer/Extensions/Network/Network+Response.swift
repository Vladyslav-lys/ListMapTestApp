//
//  Network+Response.swift
//  Network
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import Foundation

extension Network {
    public class Response {
        let data: Data
        public let response: HTTPURLResponse
        public let request: URLRequest?
        let metrics: URLSessionTaskMetrics?

        public init(
            data: Data,
            response: HTTPURLResponse,
            request: URLRequest? = nil,
            metrics: URLSessionTaskMetrics? = nil
        ) {
            self.data = data
            self.request = request
            self.response = response
            self.metrics = metrics
        }
    }
}
