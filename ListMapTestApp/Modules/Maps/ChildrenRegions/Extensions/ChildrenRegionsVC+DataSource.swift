//
//  ChildrenRegionsVC+DataSource.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 03.03.2025.
//

import UIKit
import Services

extension ChildrenRegionsVC {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: Hashable, Equatable {
        case region
    }
    
    enum Item: Hashable, Equatable {
        case region(regionFlow: RegionFlow)
    }
    
    func makeDataSource(tableView: UITableView) -> DataSource {
        DataSource(regionTVCDelegate: self, tableView: tableView)
    }
    
    func makeSnapshot(regionFlow: RegionFlow) -> Snapshot {
        with(NSDiffableDataSourceSnapshot<Section, Item>()) { snapshot in
            snapshot.appendSections([.region])
            
            switch regionFlow {
            case .country(let country):
                country.regions.forEach { region in
                    snapshot.appendItems([.region(regionFlow: .region(region: region))], toSection: .region)
                }
            case .region(let region):
                region.provinces.forEach { province in
                    snapshot.appendItems([.region(regionFlow: .province(province: province))], toSection: .region)
                }
            case .province(let province):
                province.districts.forEach { district in
                    snapshot.appendItems([.region(regionFlow: .district(district: district))], toSection: .region)
                }
            case .district:
                return
            }
        }
    }
}

extension ChildrenRegionsVC {
    final class DataSource: UITableViewDiffableDataSource<Section, Item> {
        init(regionTVCDelegate: RegionTVCDelegate?, tableView: UITableView) {
            super.init(tableView: tableView) { tableView, indexPath, item in
                switch item {
                case .region(let regionFlow):
                    tableView.makeCell(RegionTVC.self, for: indexPath) {
                        $0.configure(flow: regionFlow)
                        $0.delegate = regionTVCDelegate
                    }
                }
            }
        }
        
        override func tableView(_ tableView: UITableView,  titleForHeaderInSection section: Int) -> String? {
            R.string.localizable.regions()
        }
    }
}
