//
//  BaseService.swift
//  Services
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import NetworkLayer

public class BaseService {
    @discardableResult
    func perform<T>(completion: @escaping () async throws -> T) async throws -> T {
        do {
            return try await completion()
        } catch let error as ServiceError {
            throw error
        }
    }
}
