//
//  District.swift
//  Services
//
//  Created by Vladyslav Lysenko on 28.02.2025.
//

import Foundation

public class District: Identifiable {
    public let id: String
    public let name: String
    public let hasMap: Bool
    public unowned var province: Province
    
    init(name: String, province: Province, hasMap: Bool) {
        id = UUID().uuidString
        self.name = name
        self.province = province
        self.hasMap = hasMap
    }
}

extension District: FilenamePreparing {
    public var filename: String {
        "\(province.region.country.name.capitalizingFirstLetter())_\(province.region.name)_\(province.name)_\(name)_\(province.region.country.continent.name)_\(Constants.filenameSuffix)"
    }
}

extension District: NameCapitalizable {
    public var capitilizedName: String {
        name.capitalizingFirstLetter()
    }
}

extension District: Equatable {
    public static func == (lhs: District, rhs: District) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension District: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
