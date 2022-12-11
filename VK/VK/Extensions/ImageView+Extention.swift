// ImageView+Extention.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Расширение для преобразования URL в UIImage
private enum Constants {
    static let noPhoto = "noPhoto"
}

extension UIImageView {
    func loadImage(_ imageURL: String, _ networkService: NetworkService) {
        networkService.fetchFotoData(imageURL) { [weak self] data in
            guard let self,
                  let image = UIImage(data: data)
            else {
                self?.image = UIImage(named: Constants.noPhoto)
                return
            }
            self.image = image
        }
    }
}
