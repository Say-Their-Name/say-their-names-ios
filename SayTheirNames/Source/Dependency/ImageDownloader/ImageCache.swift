//
//  ImageCache.swift
//  SayTheirNames
//
//  Copyright (c) 2020 Say Their Names Team (https://github.com/Say-Their-Name)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
