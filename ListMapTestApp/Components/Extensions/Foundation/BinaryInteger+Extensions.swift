//
//  BinaryInteger+Extensions.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 24.02.2025.
//

import Foundation

extension BinaryInteger {
    var toGB: Double {
        Double(self / 1_073_741_824)
    }
    
    var gbString: String {
        String(format:"%.2f", toGB)
    }
}
