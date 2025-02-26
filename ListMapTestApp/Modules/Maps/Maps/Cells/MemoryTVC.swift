//
//  MemoryTVC.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 25.02.2025.
//

import UIKit

final class MemoryTVC: UITableViewCell {
    // MARK: - Constants
    private enum PrivateConstants {
        static let horizontalSpace: CGFloat = 16
        static let verticalSpace: CGFloat = 12
        static let progressLabelSpace: CGFloat = 9
        static let progressRadius: CGFloat = 8
        static let labelFont: UIFont = .systemFont(ofSize: 13, weight: .regular)
    }
    
    // MARK: - Views
    private lazy var deviceMemoryLabel: UILabel = {
        var label = UILabel()
        label.font = PrivateConstants.labelFont
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var freeMemoryLabel: UILabel = {
        var label = UILabel()
        label.font = PrivateConstants.labelFont
        label.numberOfLines = 1
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        var progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.5, animated: false)
        progressView.trackTintColor = .ghostWhite
        progressView.progressTintColor = .mandarin
        progressView.layer.cornerRadius = PrivateConstants.progressRadius
        progressView.layer.masksToBounds = true
        if let sublayers = progressView.layer.sublayers, sublayers.count > 1 && progressView.subviews.count > 1 {
            progressView.layer.sublayers?[1].cornerRadius = PrivateConstants.progressRadius
            progressView.subviews[1].clipsToBounds = true
        }
        return progressView
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
        setupProgressView()
        setupDeviceMemoryLabel()
        setupFreeMemoryLabel()
        setupDividerView()
    }
    
    // MARK: - Setup
    private func setupBackgroundColor() {
        contentView.backgroundColor = .white
    }
    
    private func setupProgressView() {
        contentView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 16),
            progressView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PrivateConstants.horizontalSpace),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PrivateConstants.horizontalSpace),
            progressView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -PrivateConstants.verticalSpace)
        ])
    }
    
    private func setupDeviceMemoryLabel() {
        contentView.addSubview(deviceMemoryLabel)
        
        NSLayoutConstraint.activate([
            deviceMemoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PrivateConstants.verticalSpace),
            deviceMemoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PrivateConstants.horizontalSpace),
            deviceMemoryLabel.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -PrivateConstants.progressLabelSpace)
        ])
    }
    
    private func setupFreeMemoryLabel() {
        contentView.addSubview(freeMemoryLabel)
        
        NSLayoutConstraint.activate([
            freeMemoryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PrivateConstants.verticalSpace),
            freeMemoryLabel.leadingAnchor.constraint(equalTo: deviceMemoryLabel.trailingAnchor, constant: .zero),
            freeMemoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PrivateConstants.horizontalSpace),
            freeMemoryLabel.bottomAnchor.constraint(equalTo: deviceMemoryLabel.bottomAnchor, constant: .zero)
        ])
    }
    
    private func setupDividerView() {
        contentView.addSubview(dividerView)
        
        NSLayoutConstraint.activate([
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .zero),
            dividerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: .zero),
            dividerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: .zero)
        ])
    }
    
    // MARK: - Configure
    func configure(freeSpace: Int64, totalSpace: Int64) {
        deviceMemoryLabel.text = R.string.localizable.deviceMemory()
        freeMemoryLabel.text = R.string.localizable.freeGb(freeSpace.gbString)
    }
}
