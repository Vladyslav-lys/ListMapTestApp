//
//  MapsService.swift
//  Services
//
//  Created by Vladyslav Lysenko on 26.02.2025.
//

import NetworkLayer

public final class MapsService: MapsUseCases {
    // MARK: - Private Properties
    private let context: ServiceContext
    private var downloadTasks: [String: Network.Request?] = [:]
    
    // MARK: - Initialize
    public init(context: ServiceContext) {
        self.context = context
    }
    
    // MARK: - Use Cases
    public func getContinents(from fileURL: URL) async throws -> [Continent] {
        let xmlData = try Data(contentsOf: fileURL)
        let parser = ContinentParser(data: xmlData)
        let continents = parser.parse().filter({ !$0.countries.isEmpty })
        return continents
    }
    
    public func downloadMap(by filename: String, progress: @escaping (Int64, Int64) -> Void) async throws {
        try await context.network
            .request(
                API.Maps.downloadMap(params: ["standard": "yes", "file": filename], destination: makeDownloadDestination(for: filename)),
                progress: progress
            ) { [unowned self] task in
                downloadTasks[filename] = task
            }
    }
    
    public func cancelTask(by filename: String) async throws {
        downloadTasks[filename]??.cancel()
        downloadTasks[filename] = nil
    }
    
    // MARK: - Helpers
    private func makeDownloadDestination(for filename: String) -> Network.DownloadDestination {
        Network.suggestedDownloadDestination(name: filename)
    }
}
