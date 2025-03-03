//
//  MapsVC+DataSource.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 25.02.2025.
//

import UIKit
import Services

extension MapsVC {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: Hashable, Equatable {
        case memory
        case continents(continent: Continent)
    }
    
    enum Item: Hashable {
        case memory(freeSpace: Int64, totalSpace: Int64)
        case countries(country: Country)
    }
    
    func makeDataSource(tableView: UITableView) -> DataSource {
        DataSource(tableView: tableView)
    }
    
    func makeSnapshot(freeSpace: Int64, totalSpace: Int64, continents: [Continent]) -> Snapshot {
        with(NSDiffableDataSourceSnapshot<Section, Item>()) { snapshot in
            snapshot.appendSections([.memory])
            snapshot.appendItems([.memory(freeSpace: freeSpace, totalSpace: totalSpace)], toSection: .memory)
            continents.forEach { continent in
                snapshot.appendSections([.continents(continent: continent)])
                continent.countries.forEach { country in
                    snapshot.appendItems([.countries(country: country)], toSection: .continents(continent: continent))
                }
            }
        }
    }
}

extension MapsVC {
    final class DataSource: UITableViewDiffableDataSource<Section, Item> {
        init(tableView: UITableView) {
            super.init(tableView: tableView) { tableView, indexPath, item in
                switch item {
                case .memory(let freeSpace, let totalSpace):
                    tableView.makeCell(MemoryTVC.self, for: indexPath) {
                        $0.configure(freeSpace: freeSpace, totalSpace: totalSpace)
                    }
                case .countries(let country):
                    tableView.makeCell(RegionTVC.self, for: indexPath) {
                        $0.configure(
                            name: country.name,
                            filename: country.filename,
                            progress: country.progress,
                            hasChildren: !country.regions.isEmpty,
                            hasMap: country.hasMap
                        )
                    }
                }
            }
        }
        
        override func tableView(_ tableView: UITableView,  titleForHeaderInSection section: Int) -> String? {
            switch snapshot().sectionIdentifiers[section] {
            case .memory: nil
            case .continents(let continent): continent.name.uppercased()
            }
        }
    }
}
