//
//  DownloadOperation.swift
//  Say Their Names
//
//  Created by Kyle Lee on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

/// An operation responsible for downloading data from a given URL
final class DownloadOperation: AsyncOperation {
    
    /// Path to asset to be downloaded
    private let url: URL
    
    /// The data of the downloaded image
    /// - Note: This data is provided asynchronously
    private var downloadedData: Data?
    
    /// Reference to the current `FileDownloader` for this operation
    private var downloader: FileDownloader?
    
    /// Creates a `DownloadOperation` from a `URL`
    init(url: URL) {
        self.url = url
    }
    
    /// Creates a `DownloadOperation` from a `String`
    convenience init(urlPath: String) throws {
        // Attempt to create a valid URL
        guard let url = URL(string: urlPath) else {
            throw Error.invalidUrlPath
        }
        
        self.init(url: url)
    }
    
    override func main() {
        // Verify that the operation isn't already cancelled
        guard isNotCancelled else { return }
        
        // Download the data at the
        downloader = FileDownloader(
            downloadCompleted: { [weak self] data in
                guard
                    let self = self,
                    self.isNotCancelled
                    else { return }
                
                // Update the downloadedData
                self.downloadedData = data
                
                // Update operation state
                self.state = .finished
            }
        )
        
        // Start the download process
        downloader?.downloadFile(at: url)
    }
}

extension DownloadOperation {
    enum Error: Swift.Error {
        case invalidUrlPath
    }
}

extension DownloadOperation: FileDataProvider {
    var fileData: Data? {
        downloadedData
    }
}
