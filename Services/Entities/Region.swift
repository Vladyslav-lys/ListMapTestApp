//
//  Region.swift
//  Services
//
//  Created by Vladyslav Lysenko on 26.02.2025.
//

import Foundation

public class Region: Identifiable {
    public let id: String
    public let name: String
    public let hasMap: Bool
    public unowned var country: Country
    public var provinces: [Province]
    
    init(name: String, country: Country, provinces: [Province], hasMap: Bool) {
        id = UUID().uuidString
        self.name = name
        self.country = country
        self.provinces = provinces
        self.hasMap = hasMap
    }
}

extension Region: FilenamePreparing {
    public var filename: String {
        "\(country.name.capitalizingFirstLetter())_\(name)_\(country.continent.name)_\(Constants.filenameSuffix)"
    }
}

extension Region: NameCapitalizable {
    public var capitilizedName: String {
        name.capitalizingFirstLetter()
    }
}

extension Region: Equatable {
    public static func == (lhs: Region, rhs: Region) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension Region: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
