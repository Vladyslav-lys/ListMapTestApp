//
//  NetworkPlugin.swift
//  Network
//
//  Created by Vladyslav Lysenko on 21.02.2025.
//

import Foundation

public protocol NetworkPlugin {
    func prepare(_ request: URLRequest, target: RequestConvertible) throws -> URLRequest
}

extension NetworkPlugin {
    public func prepare(
        _ request: URLRequest,
        target: RequestConvertible
    ) -> URLRequest {
        request
    }
}
