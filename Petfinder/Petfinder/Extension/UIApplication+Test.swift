//
//  UIApplication+Test.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 8/3/22.
//

import UIKit.UIApplication

extension UIApplication {
    public static var isRunningTest: Bool {
        return ProcessInfo().arguments.contains(K.testMode)
    }
}
