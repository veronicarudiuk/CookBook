//
//  CollectionExtension.swift
//  CookBook
//
//  Created by vasily on 06.12.2022.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
