//
//  BaseNavigationController.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import UIKit

final class BaseNavigationVC: UINavigationController {
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        
        let appearance = with(UINavigationBarAppearance()) {
            $0.configureWithOpaqueBackground()
            $0.backgroundColor = .mandarin
            $0.titleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
                .foregroundColor: UIColor.white
            ]
            $0.largeTitleTextAttributes = [
                .font: UIFont.systemFont(ofSize: 34, weight: .bold),
                .foregroundColor: UIColor.white
            ]
        }
        
        with(navigationBar) {
            $0.prefersLargeTitles = true
            $0.barTintColor = .mandarin
            $0.tintColor = .white
            $0.barStyle = .black
            $0.scrollEdgeAppearance = appearance
            $0.standardAppearance = appearance
        }
    }
}

// MARK: - UIGestureRecognizerDelegate
extension BaseNavigationVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}


