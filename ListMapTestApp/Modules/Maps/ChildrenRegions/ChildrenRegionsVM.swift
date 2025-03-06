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
    @Published var downloadingFlows: [String: RegionFlow] = [:]
    
    // MARK: - Initialize
    init(useCases: UseCases, regionFlow: RegionFlow, delegate: ChildrenRegionsVMDelegate?) {
        self.useCases = useCases
        self.regionFlow = regionFlow
        self.delegate = delegate
        super.init()
    }
    
    // MARK: - Public methods
    func showRegionList(with regionFlow: RegionFlow) {
        delegate?.didTappedCell(self, regionFlow: regionFlow)
    }
    
    func downloadMap(with regionFlow: RegionFlow) {
        let filename = regionFlow.filename
        downloadingFlows[filename] = regionFlow
        Task {
            try await useCases.maps.downloadMap(by: filename) { [weak self] total, completed in
                self?.updateDownloadingFlow(by: filename, completed: completed, total: total)
            }
        }
    }
    
    func cancelDownload(by filename: String) {
        Task {
            try await useCases.maps.cancelTask(by: filename)
            updateDownloadingFlow(by: filename, completed: .zero, total: .zero)
            downloadingFlows[filename] = nil
        }
    }
    
    func cancelAllDownloads() {
        downloadingFlows.map(\.value).forEach {
            cancelDownload(by: $0.filename)
        }
    }
    
    // MARK: - Private methods
    private func updateDownloadingFlow(by filename: String, completed: Int64, total: Int64) {
        guard var flow = downloadingFlows[filename] else { return }
        flow.updateProgress(completed: completed, total: total)
        downloadingFlows[filename] = flow
    }
}
