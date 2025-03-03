//
//  MapsVM.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import Services

final class MapsVM: BaseVM, UseCasesConsumer {
    typealias UseCases = HasMemoryUseCases & HasMapsUseCases
    
    // MARK: - Public properties
    var useCases: UseCases
    @Published var freeSpace: Int64 = 0
    @Published var totalSpace: Int64 = 0
    @Published var continents: [Continent] = []
    
    // MARK: - Initialize
    init(useCases: UseCases) {
        self.useCases = useCases
        super.init()
        getContinents()
    }
    
    // MARK: - Methods
    func getSpace() {
        freeSpace = useCases.memory.getFreeSpace()
        totalSpace = useCases.memory.getTotalSpace()
    }
    
    func getContinents() {
        Task {
            continents = try await useCases.maps.getContinents(from: R.file.regionsXml()!)
        }
    }
}
