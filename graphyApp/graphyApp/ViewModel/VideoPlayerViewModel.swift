//
//  VideoPlayerViewModel.swift
//  graphyApp
//
//  Created by Sudhakar on 02/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit
import Photos

protocol VideoPlayerViewProtocol: class {
    func playVideofrom(assetLocation: URL)
    func videoError()
}

class VideoPlayerViewModel {
    
    weak var delegate: VideoPlayerViewProtocol?

    func downloadVideoLinkAndCreateAsset(_ videoLink: String) {
        
        guard let videoURL = URL(string: videoLink) else { return }
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        if !FileManager.default.fileExists(atPath: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent).path) {
            URLSession.shared.downloadTask(with: videoURL) { (location, response, error) -> Void in
                guard let location = location else { return }
                let destinationURL = documentsDirectoryURL.appendingPathComponent(response?.suggestedFilename ?? videoURL.lastPathComponent)
                do {
                    try FileManager.default.moveItem(at: location, to: destinationURL)
                    PHPhotoLibrary.requestAuthorization({ (authorizationStatus: PHAuthorizationStatus) -> Void in
                        if authorizationStatus == .authorized {
                            PHPhotoLibrary.shared().performChanges({
                            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: destinationURL)}) { completed, error in
                                if completed {
                                    self.delegate?.playVideofrom(assetLocation: destinationURL)
                                } else {
                                    self.delegate?.videoError()
                                }
                            }
                        }
                    })
                } catch { self.delegate?.videoError() }
            }.resume()
            
        } else {
            self.delegate?.playVideofrom(assetLocation: documentsDirectoryURL.appendingPathComponent(videoURL.lastPathComponent))
        }
    }
}
