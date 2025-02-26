//
//  UseCasesProvider.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 23.02.2025.
//

import Services

protocol HasMemoryUseCases {
    var memory: MemoryUseCases { get }
}

typealias UseCases = HasMemoryUseCases

protocol UseCasesProvider: UseCases {}
