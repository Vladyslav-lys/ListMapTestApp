//
//  CachedRequestConvertible.swift
//  Network
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import Foundation

struct CachedRequestConvertible: RequestConvertible {
    let baseURL: URL?
    let method: Network.Method?
    let task: Network.Task
    let headers: Network.Headers?

    init(_ target: RequestConvertible) {
        baseURL = target.baseURL
        method = target.method
        task = target.task
        headers = target.headers
    }
}
