//
//  ImageService.swift
//  Say Their Names
//
//  Created by Kyle Lee on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit

/// A service responsible for orchestrating the downloading and caching of
/// requested `UIImage`s
final class ImageService {
    private let imageCache = ImageCache()
    
    /// Retrieves a `UIImage` from the `ImageCache` by using the path to look
    /// up the image. If the image is not already cached, operations will go
    /// into effect to download the image data, convert the data to an
    /// `UIImage`, then cache the `UIImage` before sending it through the
    /// completion block.
    /// - Parameter path: The url path of the image
    /// - Parameter completion: The completion block that is called when an
    /// `UIImage` is provided
    /// - Returns: The operation queue being used to download the image if
    /// it wasn't already cached
    @discardableResult
    func getImage(
        for path: String,
        completion: @escaping (UIImage?) -> Void
    ) -> OperationQueue? {
        
        // Block used to send the `UIImage` back on the main thread
        let sendImageOnMain: (UIImage?) -> Void = { image in
            OperationQueue.main.addOperation {
                completion(image)
            }
        }
        
        // Try to return a cached version of the `UIImage` first
        if let cachedImage = imageCache.image(for: path) {
            // Send cached image
            sendImageOnMain(cachedImage)
            
            // Dont return a queue since the `UIImage` is readily available
            return nil
            
        } else {
            // Download the image data
            guard let downloadOp = try? DownloadOperation(urlPath: path) else { return nil }
            
            // Create an image from that data
            let imageCreationOp = ImageCreationOperation()
            
            // Cache the image before sending
            let cacheAndSendImageOp = BlockOperation { [weak self] in
                guard let image = imageCreationOp.image else { return }
                self?.imageCache.cache(image, for: path)
                sendImageOnMain(image)
            }
            
            // Establish dependencies
            downloadOp ==> imageCreationOp ==> cacheAndSendImageOp
            
            // Send the operations to a new queue
            let queue = OperationQueue()
            queue.addOperations(
                [downloadOp, imageCreationOp, cacheAndSendImageOp],
                waitUntilFinished: false
            )
            
            // Return the queue in progress
            return queue
        }
    }
}
