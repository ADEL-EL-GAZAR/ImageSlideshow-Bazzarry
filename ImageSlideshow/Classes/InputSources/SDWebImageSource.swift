//
//  SDWebImageSource.swift
//  ImageSlideshow
//
//  Created by Nik Kov on 06.07.16.
//
//

import UIKit
#if SWIFT_PACKAGE
import ImageSlideshow
#endif
import SDWebImage

/// Input Source to image using SDWebImage
@objcMembers
public class SDWebImageSource: NSObject, InputSource {
    /// url to load
    public var url: URL

    /// placeholder used before image is loaded
    public var placeholder: UIImage?

    /// failureImage after image load fails
    public var failureImage: UIImage?

    /// Initializes a new source with a URL
    /// - parameter url: a url to be loaded
    /// - parameter placeholder: a placeholder used before image is loaded
    public init(url: URL, placeholder: UIImage? = nil, failureImage: UIImage? = nil) {
        self.url = url
        self.placeholder = placeholder
        self.failureImage = failureImage
        super.init()
    }

    /// Initializes a new source with a URL string
    /// - parameter urlString: a string url to load
    /// - parameter placeholder: a placeholder used before image is loaded
    public init?(urlString: String, placeholder: UIImage? = nil, failureImage: UIImage? = nil) {
        if let validUrl = URL(string: urlString) {
            self.url = validUrl
            self.placeholder = placeholder
            self.failureImage = failureImage
            super.init()
        } else {
            return nil
        }
    }

    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        imageView.sd_setImage(with: self.url, placeholderImage: self.placeholder, options: [], completed: { (image, _, _, _) in
            if image == nil {
                callback(self.failureImage)
            } else {
                callback(image)
            }
        })
    }

    public func cancelLoad(on imageView: UIImageView) {
        imageView.sd_cancelCurrentImageLoad()
    }
}
