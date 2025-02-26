//
//  With.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import Foundation

@discardableResult
public func with<T>(_ value: T,
                    _ builder: (inout T) throws -> Void) rethrows -> T {
    var mutableValue = value
    try builder(&mutableValue)
    return mutableValue
}
