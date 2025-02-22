//
//  Network+Async.swift
//  Network
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import Foundation

extension Network {
    @discardableResult
    public func request(
        _ request: RequestConvertible,
        progress: ((Double) -> Void)? = nil,
        qos: DispatchQoS.QoSClass = .default
    ) async throws -> Network.Response {
        try await withUnsafeThrowingContinuation { [weak self] continuation in
            self?.request(request, qos: qos, progress: progress) { result in
                switch result {
                case .success(let response): continuation.resume(returning: response)
                case .failure(let error): continuation.resume(throwing: NetworkError(error))
                }
            }
        }
    }
}
