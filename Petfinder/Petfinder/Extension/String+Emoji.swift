//
//  String+Emoji.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 9/3/22.
//

import UIKit.UIImage

extension String {
    func image(font: UIFont = UIFont.systemFont(ofSize: 20),
               renderingMode: UIImage.RenderingMode = .alwaysOriginal) -> UIImage? {
        let stringBounds = (self as NSString).size(withAttributes: [.font: font])
        UIGraphicsBeginImageContextWithOptions(stringBounds, false, 3)
        UIColor.clear.setFill()
        let dimension = font.pointSize
        let centerX = (stringBounds.width - dimension) / 3
        let rect = CGRect(
            origin: .init(x: centerX, y: .zero),
            size: stringBounds
        )
        UIRectFill(rect)
        (self as NSString).draw(
            in: rect,
            withAttributes: [.font: font]
        )
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.withRenderingMode(renderingMode)
     }
}
