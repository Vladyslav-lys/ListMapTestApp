//
//  APIError+Status.swift
//  Network
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import Foundation

public extension APIError {
    enum Status {
        case invalidParams
        case unauthorized
        case forbidden
        case notFound
        case otherServerError
        case other
        
        var message: String {
            switch self {
            case .invalidParams: "Invalid params"
            case .unauthorized: "Unauthorized"
            case .forbidden: "Forbidden token"
            case .notFound: "Not found"
            case .otherServerError: "Server error"
            case .other: "Unknown error"
            }
        }
    }
}
