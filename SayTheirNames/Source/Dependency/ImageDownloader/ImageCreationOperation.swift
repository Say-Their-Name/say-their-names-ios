//
//  ImageCreationOperation.swift
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

/// An operation responsible for creating a `UIImage` from `Data`
/// - Note: This operation will check its dependencies for a
///  `FileDataProvider` if `imageData` is not injected
final class ImageCreationOperation: Operation {
    /// The image created from the data
    private var createdImage: UIImage?
    /// Image data injected into the operation
    private let imageData: Data?
    
    init(imageData: Data? = nil) {
        self.imageData = imageData
    }
    
    override func main() {
        // Check if the operation has been cancelled
        guard isNotCancelled else { return }
        
        // Use imageData if it was injected
        if let imageData = imageData {
            // Set created image
            createdImage = UIImage(data: imageData)
            
        // Check for a `FileDataProvider` dependency
        } else if let dataProvider = dependencies
            .filter({ $0 is FileDataProvider })
            .first as? FileDataProvider,
            
            // Access the `fileData` from the provider
            let imageData = dataProvider.fileData {
            
            // Set created image
            createdImage = UIImage(data: imageData)
        }
    }
}

extension ImageCreationOperation: ImageProvider {
    var image: UIImage? {
        createdImage
    }
}
