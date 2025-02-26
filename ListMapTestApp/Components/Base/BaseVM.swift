//
//  BaseVM.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import Combine

class BaseVM {
    @Published var error: Error?
    var subscriptions: Set<AnyCancellable> = []
    
    deinit {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
    
    func perform(completion: @escaping () async throws -> Void) {
        Task { @MainActor in
            do {
                try await completion()
            } catch {
                self.error = error
            }
        }
    }
}
