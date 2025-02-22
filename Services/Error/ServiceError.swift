//
//  ServiceError.swift
//  Services
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import Network

public enum ServiceError: Error {
    case network(error: NetworkError)
    case undefined
}

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .network(let error): error.errorDescription
        default: nil
        }
    }
}
