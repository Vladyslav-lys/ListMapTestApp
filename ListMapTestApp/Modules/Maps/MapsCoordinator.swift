//
//  MapsCoordinator.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import UIKit
import Services

final class MapsCoordinator: Coordinator {
    // MARK: - Public Properties
    let useCases: UseCasesProvider
    
    // MARK: - Private properties
    private lazy var factory: MapsFactoryProtocol = MapsFactory(coordinator: self)
    private unowned var presenter: UINavigationController
    
    // MARK: - Lifecycle
    init(presenter: UINavigationController, useCases: UseCasesProvider) {
        self.useCases = useCases
        self.presenter = presenter
    }
    
    deinit {
        print(#function, " \(self)")
    }
    
    // MARK: - Start
    func start(animated: Bool) {
        let mapsVC = factory.makeMapsVC(delegate: self)
        presenter.pushViewController(mapsVC, animated: animated)
    }
    
    // MARK: - Helpers
    private func showChidrenRegions(with regionFlow: RegionFlow) {
        let childrenRegionsVC = factory.makeChildrenRegionsVC(regionFlow: regionFlow, delegate: self)
        presenter.pushViewController(childrenRegionsVC, animated: true)
    }
}

// MARK: - MapsVCDelegate
extension MapsCoordinator: MapsVMDelegate {
    func didTappedCell(_ vm: MapsVM, regionFlow: RegionFlow) {
        showChidrenRegions(with: regionFlow)
    }
}

// MARK: - ChildrenRegionsVMDelegate
extension MapsCoordinator: ChildrenRegionsVMDelegate {
    func didTappedCell(_ vm: ChildrenRegionsVM, regionFlow: RegionFlow) {
        showChidrenRegions(with: regionFlow)
    }
}
