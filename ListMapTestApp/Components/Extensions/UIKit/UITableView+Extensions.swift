//
//  UITableView+Extensions.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 25.02.2025.
//

import UIKit

extension UITableView {
    // MARK: - Cell
    func register(_ types: UITableViewCell.Type...) {
        types.forEach(register)
    }
    
    func register<T>(for cellClass: T.Type) where T: UITableViewCell {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
      guard let cell = dequeueReusableCell(withIdentifier: String(describing: cellClass), for: indexPath) as? T else {
        fatalError("Cannot find cell \(String(describing: cellClass))")
      }
      return cell
    }
    
    func makeCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath, builder: (T) -> Void) -> T {
        with(dequeueReusableCell(cellClass: cellClass, for: indexPath)) {
            builder($0)
        }
    }
}
