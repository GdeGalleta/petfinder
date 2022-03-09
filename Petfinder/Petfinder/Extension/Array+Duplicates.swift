//
//  Array+Duplicates.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 9/3/22.
//

import Foundation

public extension Array where Element: Hashable {

    private func removingDuplicates() -> [Element] {
        var filterDictionary = [Element: Bool]()
        return filter {
            filterDictionary.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
