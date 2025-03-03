//
//  ContinentParser.swift
//  Services
//
//  Created by Vladyslav Lysenko on 28.02.2025.
//

import Foundation

final class ContinentParser: NSObject, XMLParserDelegate {
    private let parser: XMLParser
    private var stack: [AnyObject] = []
    private var continents: [Continent] = []
    private var regionType: RegionType = .world

    init(data: Data) {
        parser = XMLParser(data: data)
        super.init()
        parser.delegate = self
    }

    func parse() -> [Continent] {
        parser.parse()

        guard parser.parserError == nil else {
            return []
        }

        return continents
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        guard elementName == "region" else { return }
        regionType.next()
        guard let name = attributeDict["name"] else { return }
        let hasMap = attributeDict["type"] == "map" || attributeDict["map"] == "yes"
        switch regionType {
        case .world:
            return
        case .continent:
            let continent = Continent(name: name, countries: [], hasMap: hasMap)
            continents.append(continent)
            stack.append(continent)
        case .country:
            guard let continent = stack.last as? Continent else { return }
            let country = Country(name: name, continent: continent, regions: [], hasMap: hasMap)
            continent.countries.append(country)
            stack.append(country)
        case .region:
            guard let country = stack.last as? Country else { return }
            let region = Region(name: name, country: country, provinces: [], hasMap: hasMap)
            country.regions.append(region)
            stack.append(region)
        case .province:
            guard let region = stack.last as? Region else { return }
            let province = Province(name: name, region: region, districts: [], hasMap: hasMap)
            region.provinces.append(province)
            stack.append(province)
        case .district:
            guard let province = stack.last as? Province else { return }
            let district = District(name: name, province: province, hasMap: hasMap)
            province.districts.append(district)
            stack.append(district)
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        guard !stack.isEmpty else { return }
        regionType.previous()
        stack.removeLast()
    }
}
