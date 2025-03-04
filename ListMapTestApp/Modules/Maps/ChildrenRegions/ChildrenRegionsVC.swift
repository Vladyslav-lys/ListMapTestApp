//
//  ChildrenRegionsVC.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 03.03.2025.
//

import UIKit
import Services

extension ChildrenRegionsVC: Makeable {
    static func make() -> ChildrenRegionsVC { ChildrenRegionsVC() }
}

final class ChildrenRegionsVC: BaseVC, ViewModelContainer {
    // MARK: - Views
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(RegionTVC.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Private properties
    private lazy var dataSource = makeDataSource(tableView: tableView)
    
    // MARK: - View model
    var viewModel: ChildrenRegionsVM?
    
    // MARK: - Lifecycle
    override func bind() {
        super.bind()
        guard let viewModel else { return }
        setupViewModel()
        
        viewModel.$regionFlow
            .sink { [weak self] regionFlow in
                guard let self else { return }
                self.setupNavigationBarTitle(with: regionFlow)
                let snapshot = self.makeSnapshot(regionFlow: regionFlow)
                self.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &subscriptions)
    }
    
    override func setupVC() {
        super.setupVC()
        setupNavigationBarStyle()
        setupTableView()
    }
    
    // MARK: - Setup
    private func setupNavigationBarTitle(with regionFlow: RegionFlow) {
        navigationItem.title = regionFlow.capitilizedName
    }
    
    private func setupNavigationBarStyle() {
        navigationItem.largeTitleDisplayMode = .never
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
extension ChildrenRegionsVC: RegionTVCDelegate {
    func didTappedAction(_ cell: RegionTVC, regionFlow: RegionFlow) {
        viewModel?.showRegionList(with: regionFlow)
    }
}
