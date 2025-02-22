//
//  AppDelegate.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 19.02.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Public properties
    var window: UIWindow?
    
    // MARK: - Private properties
    private lazy var appCoordinator = AppCoordinator()

    // MARK: - Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = appCoordinator.window
        return true
    }
}

