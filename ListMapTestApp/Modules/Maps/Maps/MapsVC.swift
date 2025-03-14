//
//  MapsVC.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 19.02.2025.
//

import UIKit
import Services

extension MapsVC: Makeable {
    static func make() -> MapsVC { MapsVC() }
}

final class MapsVC: BaseVC, ViewModelContainer {
    // MARK: - Views
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MemoryTVC.self, RegionTVC.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Private properties
    private lazy var dataSource = makeDataSource(tableView: tableView)
    
    // MARK: - View model
    var viewModel: MapsVM?
    
    // MARK: - Lifecycle
    override func bind() {
        super.bind()
        guard let viewModel else { return }
        setupViewModel()
        
        viewModel.$freeSpace
            .combineLatest(viewModel.$totalSpace, viewModel.$continents)
            .sink { [weak self] tuple in
                guard let self else { return }
                let (freeSpace, totalSpace, continents) = tuple
                let snapshot = self.makeSnapshot(freeSpace: freeSpace, totalSpace: totalSpace, continents: continents)
                self.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &subscriptions)
    }
    
    override func setupVC() {
        super.setupVC()
        setupNavigationBarTitle()
        setupTableView()
        viewModel?.getSpace()
    }
    
    // MARK: - Setup
    private func setupNavigationBarTitle() {
        navigationItem.title = R.string.localizable.downloadMaps()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: .zero),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .zero),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: .zero),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: .zero)
        ])
    }
}

// MARK: - RegionTVCDelegate
extension MapsVC: RegionTVCDelegate {
    func didTappedDownload(_ cell: RegionTVC, regionFlow: RegionFlow) {}
    
    func didTappedCancel(_ cell: RegionTVC, regionFlow: RegionFlow) {}
    
    func didTappedChevron(_ cell: RegionTVC, regionFlow: RegionFlow) {
        viewModel?.showRegionList(with: regionFlow)
    }
}
