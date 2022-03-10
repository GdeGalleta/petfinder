//
//  DecoderFactory.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 10/3/22.
//

import Foundation

public protocol GenericDecoderFactory {
    associatedtype Input
    associatedtype Output
    func decode(dto: Input) -> Output
}
