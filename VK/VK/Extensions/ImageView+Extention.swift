// ImageView+Extention.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для преобразования URL в UIImage

private enum Constants {
    static let noPhoto = "noPhoto"
}

extension UIImageView {
    func loadImage(_ imageURL: String, _ networkService: NetworkService) {
        if let url = URL(string: imageURL) {
            networkService.fetchFotoData(url) { [weak self] data in
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
}

// extension UIImageView {
//    func loadImage(urlImage: String) {
//        image = nil
//        guard let url = URL(string: urlImage) else { return }
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
//            guard let self else { return }
//            DispatchQueue.main.async {
//                guard let data else { return }
//                if let image = UIImage(data: data) {
//                    self.image = image
//                } else {
//                    self.image = UIImage(named: "noPhoto")
//                }
//            }
//        }.resume()
//    }
// }
