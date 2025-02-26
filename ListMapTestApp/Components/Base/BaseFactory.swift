//
//  BaseFactory.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import UIKit

class BaseFactory {
    private(set) weak var coordinator: Coordinator?
    var useCases: UseCasesProvider
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        useCases = coordinator.useCases
    }
}

// MARK: - Make
extension BaseFactory {
    func makeController<T: Makeable>(_ builder: T.Builder) -> T
        where T.Value == T, T: UIViewController {
        let controller: T = T.make(builder)
        return controller
    }
}
