//
//  MapsUseCases.swift
//  Services
//
//  Created by Vladyslav Lysenko on 26.02.2025.
//

import Foundation

public protocol MapsUseCases {
    func getContinents(from fileURL: URL) async throws -> [Continent]
    func downloadMap(by filename: String, progress: @escaping (Int64, Int64) -> Void) async throws
    func cancelTask(by filename: String) async throws
}
