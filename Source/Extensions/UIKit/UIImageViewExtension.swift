//
//  UIImageViewExtension.swift
//  DevelopmentKit
//
//  Created by Marko Antoljak on 27/04/2023.
//

import Foundation
import Kingfisher

public extension UIImageView {
    /// Sets constraints on width and height of a UIView.
    ///
    /// Caches the downloaded image on disk.
    ///
    /// - Parameters:
    ///   - url: URL value where the image is located.
    ///   - round: Boolean whater the proccessed UIImageView will be rounded. Default is false.
    ///   - completion: Optional completion block returning a new optional UIImageView with downloaded image from the network.
    ///
    @objc func setImage(with url: URL?, round: Bool = false, _ completion: ((UIImageView?) -> Void)? = nil) {
        kf.cancelDownloadTask()
        guard let url = url else {return}
        kf.indicatorType = .activity
        if completion == nil {
            kf.setImage(with: url,
                        options: [.cacheOriginalImage])
            return
        }
        kf.setImage(with: .network(url), options: [.cacheOriginalImage]) { result in
            switch result {
            case .success(let retrievedImage):
                let iw = UIImageView(image: retrievedImage.image)
                if round { iw.round() }
                completion?(iw)
            case .failure(let error):
                print("Error setting image: \(error.localizedDescription)")
                completion?(nil)
            }
        }
    }
}
