//
//  RegionType.swift
//  Services
//
//  Created by Vladyslav Lysenko on 28.02.2025.
//

import Foundation

enum RegionType: Int {
    case world
    case continent
    case country
    case region
    case province
    case district
    
    mutating func next() {
        self = RegionType(rawValue: rawValue + 1) ?? .district
    }
    
    mutating func previous() {
        self = RegionType(rawValue: rawValue - 1) ?? .world
    }
}
