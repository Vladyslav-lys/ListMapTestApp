//
//  NSDiffableDataSourceSnapshot+Extensions.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 06.03.2025.
//

import UIKit

extension NSDiffableDataSourceSnapshot {
    mutating func update(_ item: ItemIdentifierType, to newItem: ItemIdentifierType) {
        insertItems([newItem], beforeItem: item)
        deleteItems([item])
    }
}
