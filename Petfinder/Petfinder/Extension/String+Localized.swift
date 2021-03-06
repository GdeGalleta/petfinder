//
//  String+Localized.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
    public func localized(_ args: CVarArg...) -> String {
        return String(format: localized, arguments: args)
    }
}
