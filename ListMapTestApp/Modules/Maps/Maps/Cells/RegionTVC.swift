//
//  RegionTVC.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 03.03.2025.
//

import UIKit

protocol RegionTVCDelegate: AnyObject {
    func didTappedChevron(_ cell: RegionTVC, regionFlow: RegionFlow)
    func didTappedDownload(_ cell: RegionTVC, regionFlow: RegionFlow)
    func didTappedCancel(_ cell: RegionTVC, regionFlow: RegionFlow)
}

final class RegionTVC: BaseTableViewCell {
    // MARK: - State
    private enum State {
        case pending
        case downloading
        
        var icon: UIImage {
            switch self {
            case .pending: .icDownload
            case .downloading: .icPause
            }
        }
    }
    
    // MARK: - Constants
    private enum PrivateConstants {
        static let verticalSpace: CGFloat = 9
        static let imageSize: CGFloat = 30
        static let buttonSize: CGFloat = 30
        static let labelFont: UIFont = .systemFont(ofSize: 17, weight: .regular)
        static let progressRadius: CGFloat = 3
        static let horizontalSpace20: CGFloat = 20
        static let horizontalSpace16: CGFloat = 16
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
    
    private lazy var progressView: UIProgressView = {
        var progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = .ghostWhite
        progressView.progressTintColor = .fuksia
        progressView.layer.cornerRadius = PrivateConstants.progressRadius
        progressView.layer.masksToBounds = true
        if let sublayers = progressView.layer.sublayers, sublayers.count > 1 && progressView.subviews.count > 1 {
            progressView.layer.sublayers?[1].cornerRadius = PrivateConstants.progressRadius
            progressView.subviews[1].clipsToBounds = true
        }
        return progressView
    }()
    
    private lazy var regionNameStackView: UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    // MARK: - Public properties
    weak var delegate: RegionTVCDelegate?
    
    // MARK: - Private properties
    private var regionFlow: RegionFlow?
    private var state: State?
    
    // MARK: - Life cycles
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupMapImage()
        setupActionButton()
        setupRegionNameStackView()
        setupRegionNameLabel()
        setupProgressView()
        setupDividerView()
    }
    
    // MARK: - Setup
    private func setupMapImage() {
        contentView.addSubview(mapImageView)
        
        NSLayoutConstraint.activate([
            mapImageView.heightAnchor.constraint(equalToConstant: PrivateConstants.imageSize),
            mapImageView.widthAnchor.constraint(equalTo: mapImageView.heightAnchor),
            mapImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PrivateConstants.horizontalSpace20),
            mapImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: PrivateConstants.verticalSpace),
            mapImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -PrivateConstants.verticalSpace)
        ])
    }
    
    private func setupActionButton() {
        contentView.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            actionButton.heightAnchor.constraint(equalToConstant: PrivateConstants.buttonSize),
            actionButton.widthAnchor.constraint(equalTo: actionButton.heightAnchor),
            actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PrivateConstants.horizontalSpace20),
            actionButton.centerYAnchor.constraint(equalTo: mapImageView.centerYAnchor)
        ])
    }
    
    private func setupRegionNameStackView() {
        contentView.addSubview(regionNameStackView)
        
        NSLayoutConstraint.activate([
            regionNameStackView.centerYAnchor.constraint(equalTo: mapImageView.centerYAnchor),
            regionNameStackView.leadingAnchor.constraint(equalTo: mapImageView.trailingAnchor, constant: PrivateConstants.horizontalSpace16),
            regionNameStackView.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -PrivateConstants.horizontalSpace16)
        ])
    }
    
    private func setupRegionNameLabel() {
        regionNameStackView.addArrangedSubview(regionNameLabel)
    }
    
    private func setupProgressView() {
        regionNameStackView.addArrangedSubview(progressView)
        
        NSLayoutConstraint.activate([
            progressView.heightAnchor.constraint(equalToConstant: 3),
            progressView.leadingAnchor.constraint(equalTo: regionNameStackView.leadingAnchor, constant: .zero),
            progressView.trailingAnchor.constraint(equalTo: regionNameStackView.trailingAnchor, constant: .zero)
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
    
    private func setupProgress(completed: Int64, total: Int64) {
        progressView.isHidden = state != .downloading
        
        if total != 0 {
            let progress = Double(completed) / Double(total)
            progressView.setProgress(Float(progress), animated: false)
        }
    }
    
    // MARK: - Configure
    func configure(flow: RegionFlow) {
        regionFlow = flow
        
        let fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let destinationUrl = fileUrl.first?.appendingPathComponent(flow.filename)
        let isExist = destinationUrl.flatMap { FileManager().fileExists(atPath: $0.path) } == true
        
        if flow.hasMap && !isExist {
            if flow.totalProgress == 0 {
                state = .pending
            } else if flow.progress < flow.totalProgress {
                state = .downloading
            } else {
                state = nil
                mapImageView.tintColor = .turquoise
            }
        } else if isExist {
            mapImageView.tintColor = .turquoise
        }
        
        setupProgress(completed: flow.progress, total: flow.totalProgress)
        setupRegionName(flow.capitilizedName)
        
        if flow.hasMap {
            actionButton.setImage(state?.icon, for: .normal)
        } else if flow.hasChildren {
            actionButton.setImage(.icChevron, for: .normal)
        }
    }
    
    // MARK: - Action
    @objc private func tapAction(_ sender: UIButton) {
        guard let regionFlow else { return }
        
        if regionFlow.hasMap {
            switch state {
            case .pending:
                delegate?.didTappedDownload(self, regionFlow: regionFlow)
            case .downloading:
                delegate?.didTappedCancel(self, regionFlow: regionFlow)
            case nil:
                return
            }
            
        } else if regionFlow.hasChildren {
            delegate?.didTappedChevron(self, regionFlow: regionFlow)
        }
    }
}
