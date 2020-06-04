//
//  ImageCache.swift
//  SayTheirNames
//
//  Created by Kyle Lee on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// A `NSCache` that stores and retrieves `UIImage`s by using
/// `String` based APIs
final class ImageCache: NSCache<NSString, UIImage> {
    
    /// Saves the specified image to the cache
    /// - Parameter image: The image to be cached
    /// - Parameter key: The `String` key used to store the `UIImage`
    /// in the cache. Likely the image URL
    func cache(_ image: UIImage, for key: String) {
        setObject(image, forKey: key as NSString)
    }
    
    /// Attempts to retrieve an image by a `String` key
    /// - Parameter key: The `String` key used to retrieve the `UIImage`
    func image(for key: String) -> UIImage? {
        object(forKey: key as NSString)
    }
    
    /// Removes the `UIImage` stored by the `String` key from the cache
    /// - Parameter key: The `String` key that will be used to remove the `UIImage`
    func removeImage(for key: String) {
        removeObject(forKey: key as NSString)
    }
}
