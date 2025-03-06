//
//  RegionFlow.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 06.03.2025.
//

import Services

enum RegionFlow: Hashable, Equatable {
    case country(country: Country)
    case region(region: Region)
    case province(province: Province)
    case district(district: District)
    
    var capitilizedName: String {
        switch self {
        case .country(let country): country.capitilizedName.skipDashes()
        case .region(let region): region.capitilizedName.skipDashes()
        case .province(let province): province.capitilizedName.skipDashes()
        case .district(let district): district.capitilizedName.skipDashes()
        }
    }
    
    var hasChildren: Bool {
        switch self {
        case .country(let country): !country.regions.isEmpty
        case .region(let region): !region.provinces.isEmpty
        case .province(let province): !province.districts.isEmpty
        case .district: false
        }
    }
    
    var hasMap: Bool {
        switch self {
        case .country(let country): country.hasMap
        case .region(let region): region.hasMap
        case .province(let province): province.hasMap
        case .district(let district): district.hasMap
        }
    }
    
    var filename: String {
        switch self {
        case .country(let country): country.filename
        case .region(let region): region.filename
        case .province(let province): province.filename
        case .district(let district): district.filename
        }
    }
    
    var progress: Int64 {
        switch self {
        case .country(let country): country.progress
        case .region(let region): region.progress
        case .province(let province): province.progress
        case .district(let district): district.progress
        }
    }
    
    var totalProgress: Int64 {
        switch self {
        case .country(let country): country.totalProgress
        case .region(let region): region.totalProgress
        case .province(let province): province.totalProgress
        case .district(let district): district.totalProgress
        }
    }
    
    mutating func updateProgress(completed: Int64, total: Int64) {
        switch self {
        case .country(let country):
            country.totalProgress = total
            country.progress = completed
            self = .country(country: country)
        case .region(let region):
            region.totalProgress = total
            region.progress = completed
            self = .region(region: region)
        case .province(let province):
            province.totalProgress = total
            province.progress = completed
            self = .province(province: province)
        case .district(let district):
            district.totalProgress = total
            district.progress = completed
            self = .district(district: district)
        }
    }
}
