//
//  PetfinderImageView.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit

public class PetfinderImageView: UIImageView {

    public func loadImageData(url: URL) throws -> Data? {
        return try? Data(contentsOf: url)
    }

    public func load(url: URL, completion: (() -> Void)? = nil) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            if let data = try? self.loadImageData(url: url) {
                if let image = UIImage(data: data) {

                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.image = image
                    }
                }
            }
        }
    }
}
