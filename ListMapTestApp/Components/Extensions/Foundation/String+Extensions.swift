//
//  String+Extensions.swift
//  ListMapTestApp
//
//  Created by Vladyslav Lysenko on 03.03.2025.
//

import Foundation

extension String {
    func skipDashes() -> String {
        replacingOccurrences(of: "-", with: " ")
    }
}
