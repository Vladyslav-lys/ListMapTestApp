//
//  Platform.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 23.02.2025.
//

import NetworkLayer
import Services
import UIKit

final class Platform: UseCasesProvider {
    // MARK: - Initialize
    init() {
        let network = Network(baseURL: Environment.current.baseURL)
        let serviceContext = ServiceContext(network: network) // TODO: - This will be used in future implementations
    }
    
    // MARK: - AppDelegate
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }
}
