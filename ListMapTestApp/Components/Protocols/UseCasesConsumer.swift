//
//  UseCasesConsumer.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import Foundation

protocol UseCasesConsumer: AnyObject {
    associatedtype UseCases
    
    var useCases: UseCases { get set }
}
