//
//  Country.swift
//  Services
//
//  Created by Vladyslav Lysenko on 26.02.2025.
//

import Foundation

public class Country {
    public let name: String
    public let hasMap: Bool
    public unowned var continent: Continent
    public var regions: [Region]
    public var progress: Double
    
    init(name: String, continent: Continent, regions: [Region], hasMap: Bool, progress: Double = 0) {
        self.name = name
        self.continent = continent
        self.regions = regions
        self.hasMap = hasMap
        self.progress = progress
    }
}

extension Country: FilenamePreparing {
    public var filename: String {
        "\(name.capitalizingFirstLetter())_\(continent.name)_\(Constants.filenameSuffix)"
    }
}

extension Country: NameCapitalizable {
    public var capitilizedName: String {
        name.capitalizingFirstLetter()
    }
}

extension Country: Equatable {
    public static func == (lhs: Country, rhs: Country) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension Country: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
