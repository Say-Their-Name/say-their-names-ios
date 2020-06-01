//
//  FileDownloader.swift
//  Say Their Names
//
//  Created by Kyle Lee on 5/31/20.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation

/// Resource used to manage downloading an asset as well as monitoring
/// the state of the download
final class FileDownloader: NSObject, URLSessionDownloadDelegate {
    
    /// Block that handles the downloaded data
    private let downloadCompleted: (Data?) -> Void
    /// Block that handles the completed
    private let downloadProgressUpdated: (Float) -> Void
    
    /// Creates a `FileDownloader` with a completion block and optional
    /// download progress block
    /// - Parameter downloadCompleted: Block that handles the downloaded data
    /// - Parameter downloadProgressUpdated: Block that handles the completed
    /// download percentage as a Float
    init(
        downloadCompleted: @escaping (Data?) -> Void,
        downloadProgressUpdated: @escaping (Float) -> Void = {_ in}
    ) {
        self.downloadCompleted = downloadCompleted
        self.downloadProgressUpdated = downloadProgressUpdated
    }
    
    /// Create and starts a download task for a given URL
    /// - Parameter url: The URL of the asset to be downloaded
    func downloadFile(at url: URL) {
        
        // Create a session that will use this class as the delegate
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        
        // Start downloading the contents at the URL
        let task = session.downloadTask(with: url)
        task.resume()
    }
    
    /// Amount of bytes written and expected to write
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        // Calculate the download progress percentage
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        
        // Pass the percentage downloaded
        downloadProgressUpdated(progress)
    }
    
    /// Download completed
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        // Retrieve the data from the local download location
        let downloadedData = try? Data(contentsOf: location)
        
        // Pass the downloaded data
        downloadCompleted(downloadedData)
    }
}
