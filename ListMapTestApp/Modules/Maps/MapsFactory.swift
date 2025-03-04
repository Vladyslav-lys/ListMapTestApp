//
//  MapsFactory.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import UIKit
import Services

protocol MapsFactoryProtocol: AnyObject {
    func makeMapsVC<Delegate: MapsVMDelegate>(delegate: Delegate?) -> MapsVC
    func makeChildrenRegionsVC<Delegate: ChildrenRegionsVMDelegate>(regionFlow: RegionFlow, delegate: Delegate?) -> ChildrenRegionsVC
}

final class MapsFactory: BaseFactory, MapsFactoryProtocol {
    func makeMapsVC<Delegate: MapsVMDelegate>(delegate: Delegate?) -> MapsVC {
        makeController {
            $0.viewModel = MapsVM(useCases: useCases, delegate: delegate)
        }
    }
    
    func makeChildrenRegionsVC<Delegate: ChildrenRegionsVMDelegate>(regionFlow: RegionFlow, delegate: Delegate?) -> ChildrenRegionsVC {
        makeController {
            $0.viewModel = ChildrenRegionsVM(useCases: useCases, regionFlow: regionFlow, delegate: delegate)
        }
    }
}
