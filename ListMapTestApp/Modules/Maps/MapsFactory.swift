//
//  MapsFactory.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import UIKit

protocol MapsFactoryProtocol: AnyObject {
    func makeMapsVC() -> MapsVC
}

final class MapsFactory: BaseFactory, MapsFactoryProtocol {
    func makeMapsVC() -> MapsVC {
        makeController {
            $0.viewModel = MapsVM(useCases: useCases)
        }
    }
}
