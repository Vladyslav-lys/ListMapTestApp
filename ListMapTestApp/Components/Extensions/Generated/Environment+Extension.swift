//
//  Environment+Extension.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 23.02.2025.
//

import Foundation

extension Environment {
    var baseURL: URL {
        guard let url = URL(string: Environment.current.baseURLString) else {
            fatalError("Base URL is not valid")
        }
        return url
    }
}
