//
//  Continent.swift
//  Services
//
//  Created by Vladyslav Lysenko on 26.02.2025.
//

import Foundation

public class Continent {
    public let name: String
    public var countries: [Country]
    public let hasMap: Bool
    public var progress: Double
    
    init(name: String, countries: [Country], hasMap: Bool, progress: Double = 0) {
        self.name = name
        self.countries = countries
        self.hasMap = hasMap
        self.progress = progress
    }
}

extension Continent: Equatable {
    public static func == (lhs: Continent, rhs: Continent) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension Continent: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
