//
//  AppCoordinator.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import UIKit

final class AppCoordinator {
    // MARK: - Public Properties
    let window: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    
    // MARK: - Private Properties
    private let useCases: UseCasesProvider
    private var mapsCoordinator: Coordinator?
    
    // MARK: - Initialize
    init(useCases: UseCasesProvider) {
        self.useCases = useCases
        start()
    }
    
    // MARK: - Start
    private func start() {
        let presenter = BaseNavigationVC()
        window.rootViewController = presenter
        mapsCoordinator = MapsCoordinator(presenter: presenter, useCases: useCases)
        mapsCoordinator?.start()
        window.makeKeyAndVisible()
    }
}
