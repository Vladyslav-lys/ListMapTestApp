//
//  ServiceContext.swift
//  Services
//
//  Created by Vladyslav Lysenko on 22.02.2025.
//

import Network

public final class ServiceContext {
    let network: Network

    public init(network: Network) {
        self.network = network
    }
}
