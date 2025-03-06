//
//  Province.swift
//  Services
//
//  Created by Vladyslav Lysenko on 26.02.2025.
//

import Foundation

public class Province: Identifiable {
    public let id: String
    public let name: String
    public let hasMap: Bool
    public unowned var region: Region
    public var districts: [District]
    public var progress: Int64
    public var totalProgress: Int64
    
    init(name: String, region: Region, districts: [District], hasMap: Bool, progress: Int64 = 0, totalProgress: Int64 = 0) {
        id = UUID().uuidString
        self.name = name
        self.region = region
        self.districts = districts
        self.progress = progress
        self.hasMap = hasMap
        self.totalProgress = totalProgress
    }
}

extension Province: FilenamePreparing {
    public var filename: String {
        "\(region.country.name.capitalizingFirstLetter())_\(region.name)_\(name)_\(region.country.continent.name)_\(Constants.filenameSuffix)"
    }
}

extension Province: NameCapitalizable {
    public var capitilizedName: String {
        name.capitalizingFirstLetter()
    }
}

extension Province: Equatable {
    public static func == (lhs: Province, rhs: Province) -> Bool {
        ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

extension Province: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
