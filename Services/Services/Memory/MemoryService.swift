//
//  MemoryService.swift
//  Services
//
//  Created by Vladyslav Lysenko on 23.02.2025.
//

import Foundation

final public class MemoryService: BaseService, MemoryUseCases {
    // MARK: - Private Properties
    private let fileManager = FileManager.default
    private lazy var attributes = try? fileManager.attributesOfFileSystem(forPath: NSHomeDirectory())
    
    // MARK: - Initialize
    public override init() {}
    
    // MARK: - Use Cases
    public func getTotalSpace() -> Int64 {
        attributes?[.systemSize] as? Int64 ?? 0
    }
    
    public func getFreeSpace() -> Int64 {
        attributes?[.systemFreeSize] as? Int64 ?? 0
    }
}
