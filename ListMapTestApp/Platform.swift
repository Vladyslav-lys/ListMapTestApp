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
    // MARK: - Public Properties
    let memory: MemoryUseCases
    let maps: MapsUseCases
    
    // MARK: - Initialize
    init() {
        let network = Network(baseURL: Environment.current.baseURL)
        let serviceContext = ServiceContext(network: network)
        memory = MemoryService()
        maps = MapsService(context: serviceContext)
    }
    
    // MARK: - AppDelegate
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        true
    }
}
