//
//  BaseVC.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import UIKit
import Combine

class BaseVC: UIViewController {
    // MARK: - Properties
    @Published var error: Error?
    var subscriptions: Set<AnyCancellable> = .init()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupVC()
    }
    
    deinit {
        print("\(#function) \(self)")
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
    
    // MARK: - Public Methods
    func setupVC() {
        view.backgroundColor = .ghostWhite
        navigationItem.largeTitleDisplayMode = .always
    }
    
    func bind() {
        $error
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] in self?.showErrorAlert($0) }
            .store(in: &subscriptions)
    }
    
    func showErrorAlert(_ error: Error) {
        let controller = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
}
