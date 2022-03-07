//
//  AnimalListModel.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation

public struct AnimalListModel: Hashable {
    private let id = UUID()
    let identifier: Int
    let name: String
    let age: String?
    let gender: String?
    let size: String?
    let type: String?
    let photo: AnimalListPhotoModel?
}

public struct AnimalListPhotoModel: Hashable {
    let url: URL?
}
