//
//  ImageCreationOperation.swift
//  Say Their Names
//
//  Created by Kyle Lee on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

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
