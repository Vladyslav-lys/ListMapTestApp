//
//  APIError.swift
//  Network
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import Alamofire

public struct APIError: Decodable, LocalizedError {
    public let code: Int
    
    public var status: Status {
        switch code {
        case 400: .invalidParams
        case 401: .unauthorized
        case 403: .forbidden
        case 404: .notFound
        case 500...600: .otherServerError
        default: .other
        }
    }
}

extension Error {
    public var apiError: APIError? {
        if let apiError = self as? APIError {
            return apiError
        } else if let networkError = self as? NetworkError, case .api(let apiError) = networkError {
            return apiError
        } else if let networkError = self as? NetworkError, case .underlying(let someError) = networkError {
            return someError.apiError
        } else {
            return nil
        }
    }
    
    public var sessionTaskFailed: NetworkError? {
        if let error = self as? NetworkError, case .sessionTaskFailed = error {
            return error
        } else if let error = self as? NetworkError,
                  case .underlying(let underlyError) = error,
                  let networkError = underlyError as? NetworkError {
            return networkError.sessionTaskFailed
        } else if let error = self as? NetworkError,
                  case .underlying(let underlyError) = error,
                  let afError = underlyError as? AFError {
            return afError.sessionTaskFailed
        } else if let error = self as? AFError, case .sessionTaskFailed = error {
            return .sessionTaskFailed(error)
        }
        return nil
    }
}
