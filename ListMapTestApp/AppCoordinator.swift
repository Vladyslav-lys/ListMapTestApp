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
    
    // MARK: - Initialize
    init(useCases: UseCasesProvider) {
        self.useCases = useCases
        start()
    }
    
    private func start() {
        let presenter = UINavigationController(rootViewController: ViewController())
        window.rootViewController = presenter
        window.makeKeyAndVisible()
    }
}
