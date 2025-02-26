//
//  MapsVC+DataSource.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 25.02.2025.
//

import UIKit

extension MapsVC {
    typealias DataSource = UITableViewDiffableDataSource<Section, Item>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>
    
    enum Section: Int {
        case memory
    }
    
    enum Item: Hashable {
        case memory(freeSpace: Int64, totalSpace: Int64)
    }
    
    func makeDataSource(tableView: UITableView) -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, item in
            switch item {
            case .memory(let freeSpace, let totalSpace):
                tableView.makeCell(MemoryTVC.self, for: indexPath) {
                    $0.configure(freeSpace: freeSpace, totalSpace: totalSpace)
                }
            }
        }
    }
    
    func makeSnapshot(freeSpace: Int64, totalSpace: Int64) -> Snapshot {
        with(NSDiffableDataSourceSnapshot<Section, Item>()) {
            $0.appendSections([.memory])
            $0.appendItems([.memory(freeSpace: freeSpace, totalSpace: totalSpace)], toSection: .memory)
        }
    }
}
