//
//  MapsCoordinator.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import UIKit

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
        let mapsVC = factory.makeMapsVC()
        presenter.pushViewController(mapsVC, animated: animated)
    }
}
