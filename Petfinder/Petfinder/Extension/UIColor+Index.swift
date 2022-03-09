//
//  UIColor+Index.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 8/3/22.
//

import UIKit.UIColor

public extension UIColor {

    static func colorValueForIndex(_ index: Int) -> CGFloat {
        let multiple100module: Int = index%100/10
        let multiple10module: Int = index%10
        let reminderOver10: Int = multiple100module%2 != 0 ? 10-multiple10module : multiple10module
        let reminderOver10OutOf10: CGFloat = CGFloat(reminderOver10)/10
        return reminderOver10OutOf10
    }

    static func colorForIndex(_ index: Int,
                              overR: Bool = false,
                              overG: Bool = false,
                              overB: Bool = false) -> UIColor {
        let colorValueR = colorValueForIndex(index)
        let colorValueG = colorValueForIndex(index)
        let colorValueB = colorValueForIndex(index)
        return UIColor(
            red: overR ? colorValueR : 0.5,
            green: overG ? colorValueG : 0.5,
            blue: overB ? colorValueB : 0.5,
            alpha: 1.0
        )
    }
}
