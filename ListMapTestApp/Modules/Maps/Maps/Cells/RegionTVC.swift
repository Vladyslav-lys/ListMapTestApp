//
//  RegionTVC.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 03.03.2025.
//

import UIKit
import Services

protocol RegionTVCDelegate: AnyObject {
    func didTappedAction(_ cell: RegionTVC, regionFlow: RegionFlow)
}

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
}

final class RegionTVC: BaseTableViewCell {
    // MARK: - Constants
    private enum PrivateConstants {
        static let verticalSpace: CGFloat = 9
        static let imageSize: CGFloat = 30
        static let buttonSize: CGFloat = 30
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
    
    private lazy var actionButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Public properties
    weak var delegate: RegionTVCDelegate?
    
    // MARK: - Private properties
    private var regionFlow: RegionFlow?
    
    // MARK: - Life cycles
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMapImage()
        setupActionButton()
        setupRegionNameLabel()
        setupDividerView()
    }
    
    // MARK: - Setup
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
    
    private func setupActionButton() {
        contentView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: PrivateConstants.buttonSize),
            actionButton.widthAnchor.constraint(equalTo: actionButton.heightAnchor),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            actionButton.centerYAnchor.constraint(equalTo: mapImageView.centerYAnchor)
        ])
    }
    
    private func setupRegionNameLabel() {
        contentView.addSubview(regionNameLabel)
        
        NSLayoutConstraint.activate([
            regionNameLabel.centerYAnchor.constraint(equalTo: mapImageView.centerYAnchor),
            regionNameLabel.leadingAnchor.constraint(equalTo: mapImageView.trailingAnchor, constant: 16),
            regionNameLabel.trailingAnchor.constraint(equalTo: actionButton.trailingAnchor, constant: 16)
        ])
    }
    
    private func setupDividerView() {
        contentView.addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            dividerView.heightAnchor.constraint(equalToConstant: Constants.dividerHeight),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 66),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .zero),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .zero)
        ])
    }
    
    private func setupRegionName(_ name: String) {
        regionNameLabel.text = name
    }
    
    // MARK: - Configure
    func configure(flow: RegionFlow) {
        regionFlow = flow
        setupRegionName(flow.capitilizedName)
        switch flow {
        case .country(let country):
            if !country.regions.isEmpty {
                actionButton.setImage(.icChevron, for: .normal)
            }
        case .region(let region):
            if !region.provinces.isEmpty {
                actionButton.setImage(.icChevron, for: .normal)
            }
        case .province(let province):
            if !province.districts.isEmpty {
                actionButton.setImage(.icChevron, for: .normal)
            }
        case .district:
            return
        }
    }
    
    // MARK: - Action
    @objc private func tapAction(_ sender: UIButton) {
        guard let regionFlow, regionFlow.hasChildren else { return }
        delegate?.didTappedAction(self, regionFlow: regionFlow)
    }
}
