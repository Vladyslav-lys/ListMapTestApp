//
//  ChildrenRegionsVM.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 03.03.2025.
//

import Services

protocol ChildrenRegionsVMDelegate: AnyObject {
    func didTappedCell(_ vm: ChildrenRegionsVM, regionFlow: RegionFlow)
}

final class ChildrenRegionsVM: BaseVM, UseCasesConsumer {
    typealias UseCases = HasMapsUseCases
    
    // MARK: - Public properties
    weak var delegate: ChildrenRegionsVMDelegate?
    var useCases: UseCases
    @Published var regionFlow: RegionFlow
    
    // MARK: - Initialize
    init(useCases: UseCases, regionFlow: RegionFlow, delegate: ChildrenRegionsVMDelegate?) {
        self.useCases = useCases
        self.regionFlow = regionFlow
        self.delegate = delegate
        super.init()
    }
    
    // MARK: - Methods
    func showRegionList(with regionFlow: RegionFlow) {
        delegate?.didTappedCell(self, regionFlow: regionFlow)
    }
}
