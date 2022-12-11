// PhotoCacheService.swift
// Copyright © RoadMap. All rights reserved.

import Alamofire
import UIKit

/// Сервис для cохранения фото в кеш хранилище
class PhotoCacheService {
    // Private Constants

    private enum Constants {
        static let noPhoto = "noPhoto"
        static let folderName = "images"
        static let separator: Character = "/"
        static let defaultString: Substring = "default"
    }

    // MARK: - Public Properties

    var imagesMap: [String: UIImage] = [:]
    var placeholderImage: UIImage? = UIImage(systemName: Constants.noPhoto)

    // MARK: - Public Methods

    func photo(_ indexPath: IndexPath, _ url: String) -> UIImage? {
        if let image = imagesMap[url] {
            return image
        } else if let image = getImageFromDisk(url) {
            return image
        } else {
            loadImageFromNet(indexPath, url)
            return placeholderImage
        }
    }

    func loadImageFromNet(_ indexPath: IndexPath, _ url: String) {
        AF.request(url).responseData { [weak self] response in
            guard let data = response.data, let image = UIImage(data: data), let self else { return }
            self.imagesMap[url] = image
            self.saveImageToDisk(url, image)
            self.container.reloadRow(indexPath)
        }
    }

    func getImageFromDisk(_ url: String) -> UIImage? {
        guard let filePath = getImagePath(url), let image = UIImage(contentsOfFile: filePath) else { return nil }

        imagesMap[url] = image
        return image
    }

    // MARK: - Private Properties

    private let container: Collection
    private let networkService = NetworkService()
    private lazy var fileManager = FileManager.default

    init(__ container: UICollectionView) {
        self.container = Collection(container)
    }

    private func getCachFolderPath() -> URL? {
        guard let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
        let url = docDirectory.appendingPathComponent(Constants.folderName, isDirectory: true)

        if !fileManager.fileExists(atPath: url.path) {
            do {
                try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
            } catch {
                print(error)
            }
        }
        return url
    }

    private func getImagePath(_ url: String) -> String? {
        guard let folderUrl = getCachFolderPath() else { return nil }
        let fileName = url.split(separator: Constants.separator).last ?? Constants.defaultString
        return folderUrl.appendingPathComponent(String(fileName)).path
    }

    // MARK: - Private Methods

    private func saveImageToDisk(_ url: String, _ image: UIImage) {
        guard let filePath = getImagePath(url), let data = image.pngData() else { return }

        fileManager.createFile(atPath: filePath, contents: data)
    }
}

// MARK: - Extention PhotoCacheService

extension PhotoCacheService {
    private class Collection {
        let collection: UICollectionView

        init(_ collection: UICollectionView) {
            self.collection = collection
        }

        func reloadRow(_ indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
    }
}
