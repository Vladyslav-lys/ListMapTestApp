//
//  Coordinator.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import Foundation

protocol Coordinator: AnyObject {
    var useCases: UseCasesProvider { get }
    
    func start(animated: Bool)
    func stop(animated: Bool)
}

extension Coordinator {
    func start() {
        start(animated: true)
    }
    
    func stop(animated: Bool = true) { }
}
