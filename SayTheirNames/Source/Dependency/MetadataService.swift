//
//  MetadataService.swift
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

import Foundation
import LinkPresentation

struct LinkInformation: Hashable {
    let url: URL
    let title: String
    let image: UIImage?
}

final class MetadataService: Dependency {

    // MARK: Types
    
    enum LinkError: Error {
        case failedToLoad(String)
        case noImageData
    }
    
    enum MetadataError: Error {
        case failedToLoad(String)
    }
    
    typealias MetadataResultHandler = ((Result<LPLinkMetadata, MetadataError>) -> Void)
    typealias LinkInformationHandler = ((Result<LinkInformation, LinkError>) -> Void)
    
    private let queue = DispatchQueue(label: "stn.metadata-queue")
    private let resourceQueue = DispatchQueue(label: "stn.metadata-queue.resource")
    private var loadingOperations: [URL: OperationQueue] = [:]
    let cache = NSCache<NSString, LPLinkMetadata>()
    
    // MARK: Public Methods

    /*  This method is used to start loading a number of URLs (ideally when a view first loads).
        When the `fetchMetadata` method is called it will either use:
        a) the existing operation or
        b) the cached metadata
     */
    func preheat(with urls: [URL]) {
        _ = urls.map { self.fetchMetadata(for: $0, completionHandler: nil) }
    }
    
    // This method is used to fetch a LinkInformation object from a URL.
    func fetchLinkInformation(from url: URL,
                              completionHandler: @escaping LinkInformationHandler) {

        // First, we fetch the metadata to get information about the URL
        self.fetchMetadata(for: url) { result in
            switch result {
            case .success(let metadata):
                self.fetchResource(for: metadata, completionHandler: completionHandler)
            case .failure(let error):
                completionHandler(.failure(.failedToLoad(error.localizedDescription)))
            }
        }
    }
}

// MARK: Cache

extension MetadataService {
    
    func metadata(for url: URL) -> LPLinkMetadata? {
        let urlString = url.absoluteString as NSString
        return cache.object(forKey: urlString)
    }
    
    func store(_ metadata: LPLinkMetadata, for url: URL) {
        let urlString = url.absoluteString as NSString
        self.cache.setObject(metadata, forKey: urlString)
    }
}

// MARK: Metadata Loading

extension MetadataService {
    
    func fetchMetadata(for url: URL, completionHandler: MetadataResultHandler?) {
        if let metadata = self.metadata(for: url) {
            completionHandler?(.success(metadata))
        } else {
            queue.async {
                if let queue = self.loadingOperations[url] {
                    queue.addOperation {
                        if let metadata = self.metadata(for: url) {
                            completionHandler?(.success(metadata))
                        } else {
                            completionHandler?(.failure(.failedToLoad("Unable to find metadata with URL " + url.absoluteString)))
                        }
                    }
                } else {
                    self.loadMetadata(for: url, completionHandler: completionHandler)
                }
            }
        }
    }
    
    private func loadMetadata(for url: URL, completionHandler: MetadataResultHandler?) {
        let localQueue = OperationQueue()
        localQueue.isSuspended = true
        self.loadingOperations[url] = localQueue
        
        localQueue.addOperation {
            if let metadata = self.metadata(for: url) {
                completionHandler?(.success(metadata))
            } else {
                completionHandler?(.failure(.failedToLoad("Unable to find metadata with URL " + url.absoluteString)))
            }
        }
        
        DispatchQueue.main.async {
            let provider = LPMetadataProvider()
            provider.shouldFetchSubresources = true
            provider.timeout = 60
            
            provider.startFetchingMetadata(for: url, completionHandler: { meta, error in
                
                if let error = error {
                    completionHandler?(.failure(.failedToLoad(error.localizedDescription)))
                }
                
                if let metadata = meta {
                    self.store(metadata, for: url)
                } else {
                    completionHandler?(.failure(.failedToLoad("No metadata was returned from the URL: " + url.absoluteString)))
                }
                
                self.queue.async {
                    self.loadingOperations.removeValue(forKey: url)
                    localQueue.isSuspended = false
                }
            })
        }
    }
}

// MARK: Resource Loading
extension MetadataService {
    
    private func fetchResource(for metadata: LPLinkMetadata,
                               completionHandler: @escaping LinkInformationHandler) {
        resourceQueue.async {
            guard let imageProvider = metadata.imageProvider else {
                completionHandler(.failure(.noImageData))
                return
            }

            imageProvider.loadObject(ofClass: UIImage.self) { image, error in
                if let error = error {
                    completionHandler(.failure(.failedToLoad(error.localizedDescription)))
                }
                
                guard let url = metadata.url,
                    let title = metadata.title else {
                        completionHandler(.failure(.failedToLoad("The metadata did not return a title or URL")))
                        return
                }
                
                if let image = image as? UIImage {
                    let info = LinkInformation(url: url, title: title, image: image)
                    completionHandler(.success(info))
                } else {
                    completionHandler(.failure(.noImageData))
                }
            }
        }
    }
}
