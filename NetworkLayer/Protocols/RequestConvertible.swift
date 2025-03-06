//
//  RequestConvertible.swift
//  Network
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import Foundation

public protocol RequestConvertible {
    /// Base URL for request, takes precedence over `baseURL` in `Network` if specified.
    var baseURL: URL? { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: Network.Method? { get }

    /// The type of HTTP task to be performed.
    var task: Network.Task { get }

    /// The headers to be used in the request.
    var headers: Network.Headers? { get }
}

extension RequestConvertible {
    public var baseURL: URL? { nil }

    public var headers: Network.Headers? { nil }
    
    public var method: Network.Method? { nil }
}
