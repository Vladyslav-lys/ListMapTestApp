//
//  MemoryUseCases.swift
//  Services
//
//  Created by Vladyslav Lysenko on 23.02.2025.
//

import Foundation

public protocol MemoryUseCases {
    func getTotalSpace() -> Int64
    func getFreeSpace() -> Int64
}
