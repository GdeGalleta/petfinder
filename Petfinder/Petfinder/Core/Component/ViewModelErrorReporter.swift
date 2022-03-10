//
//  ViewModelErrorReporter.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 10/3/22.
//

import Foundation

public protocol ViewModelErrorReportable where Self: ViewModelErrorReporter {

    var errorMessage: String? { get }
    var errorMessagePublished: Published<String?> { get }
    var errorMessagePublisher: Published<String?>.Publisher { get }
}

public class ViewModelErrorReporter: ViewModelErrorReportable {

    @Published public var errorMessage: String?
    public var errorMessagePublished: Published<String?> { _errorMessage }
    public var errorMessagePublisher: Published<String?>.Publisher { $errorMessage }
}
