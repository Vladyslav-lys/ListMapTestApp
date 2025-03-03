//
//  RegionTVC.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 03.03.2025.
//

import UIKit

final class RegionTVC: UITableViewCell {
    // MARK: - Constants
    private enum PrivateConstants {
        static let verticalSpace: CGFloat = 9
        static let imageSize: CGFloat = 30
        static let labelFont: UIFont = .systemFont(ofSize: 17, weight: .regular)
    }
    
    // MARK: - Views
    private lazy var regionNameLabel: UILabel = {
        var label = UILabel()
        label.font = PrivateConstants.labelFont
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mapImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .icMap.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .middleGrey
        return imageView
    }()
    
    private lazy var dividerView: UIView = {
        var view = UIView()
        view.backgroundColor = .ghost
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Life cycles
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBackgroundColor()
        setupMapImage()
        setupRegionNameLabel()
        setupDividerView()
    }
    
    // MARK: - Setup
    private func setupBackgroundColor() {
        contentView.backgroundColor = .white
    }
    
    private func setupMapImage() {
        contentView.addSubview(mapImageView)
        
        NSLayoutConstraint.activate([
            mapImageView.heightAnchor.constraint(equalToConstant: PrivateConstants.imageSize),
            mapImageView.widthAnchor.constraint(equalTo: mapImageView.heightAnchor),
            mapImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mapImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PrivateConstants.verticalSpace),
            mapImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -PrivateConstants.verticalSpace)
        ])
    }
    
    private func setupRegionNameLabel() {
        contentView.addSubview(regionNameLabel)
        
        NSLayoutConstraint.activate([
            regionNameLabel.centerYAnchor.constraint(equalTo: mapImageView.centerYAnchor),
            regionNameLabel.leadingAnchor.constraint(equalTo: mapImageView.trailingAnchor, constant: 16),
            regionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .zero)
        ])
    }
    
    private func setupDividerView() {
        contentView.addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 66),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .zero),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .zero)
        ])
    }
    
    // MARK: - Configure
    func configure(name: String, filename: String, progress: Double, hasChildren: Bool, hasMap: Bool) {
        regionNameLabel.text = name.capitalizingFirstLetter().skipDashes()
    }
}
