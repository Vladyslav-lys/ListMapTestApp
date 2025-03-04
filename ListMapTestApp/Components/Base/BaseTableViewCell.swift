//
//  BaseTableViewCell.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 03.03.2025.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    // MARK: - Life cycles
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBackgroundColor()
    }
    
    // MARK: - Setup
    private func setupBackgroundColor() {
        contentView.backgroundColor = .white
    }
}
