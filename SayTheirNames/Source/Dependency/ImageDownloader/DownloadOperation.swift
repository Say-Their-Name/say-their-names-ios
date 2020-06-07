//
//  DownloadOperation.swift
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
