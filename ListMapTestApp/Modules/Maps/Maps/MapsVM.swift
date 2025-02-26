//
//  MapsVM.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import Services

final class MapsVM: BaseVM, UseCasesConsumer {
    typealias UseCases = HasMemoryUseCases
    
    // MARK: - Public properties
    var useCases: UseCases
    @Published var freeSpace: Int64 = 0
    @Published var totalSpace: Int64 = 0
    
    // MARK: - Initialize
    init(useCases: UseCases) {
        self.useCases = useCases
        super.init()
    }
    
    // MARK: - Methods
    func getSpace() {
        freeSpace = useCases.memory.getFreeSpace()
        totalSpace = useCases.memory.getTotalSpace()
    }
}
