//
//  ViewModelContainer.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import Foundation

protocol ViewModelContainer: AnyObject {
    associatedtype ViewModel: BaseVM
    var viewModel: ViewModel? { get set }
    func setupViewModel()
}

extension ViewModelContainer where Self: BaseVC {
    func setupViewModel() {
        viewModel?.$error
            .sink { [weak self] value in
                self?.error = value
            }
            .store(in: &subscriptions)
    }
}
