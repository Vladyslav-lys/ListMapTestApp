//
//  MapsService.swift
//  Services
//
//  Created by Vladyslav Lysenko on 26.02.2025.
//

import Foundation

public final class MapsService: MapsUseCases {
    // MARK: - Private Properties
    private let context: ServiceContext
    
    // MARK: - Initialize
    public init(context: ServiceContext) {
        self.context = context
    }
    
    // MARK: - Use Cases
    public func getContinents(from fileURL: URL) async throws -> [Continent] {
        let xmlData = try Data(contentsOf: fileURL)
        let parser = ContinentParser(data: xmlData)
        let continents = parser.parse().filter({ !$0.countries.isEmpty })
        return continents
    }
}
