//
//  VideoPlayerViewController.swift
//  graphyApp
//
//  Created by Sudhakar on 02/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoPlayerViewController: UIViewController, VideoPlayerViewProtocol {

    let videoplayerViewModel = VideoPlayerViewModel()
    var selectedVideoUrl: String?
    var playerURL : URL!
    var playerLayer : AVPlayerLayer!
    var avpController:AVPlayerViewController!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        videoplayerViewModel.delegate = self
        self.loadingIndicator.isHidden = false
        videoplayerViewModel.downloadVideoLinkAndCreateAsset(selectedVideoUrl ?? "")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func playVideofrom(assetLocation: URL) {
        DispatchQueue.main.async {
            var playerItems = [AVPlayerItem]()
            
            let asset = AVAsset(url: assetLocation)
            let playerItem = AVPlayerItem(asset: asset)
            playerItems.append(playerItem)
            
            self.avpController = AVPlayerViewController()
            let player = AVQueuePlayer(items: playerItems)
            self.avpController.player = player
            
            self.avpController.view.frame = self.videoView.bounds
            self.avpController.showsPlaybackControls = true
            self.videoView.addSubview(self.avpController.view)
            self.videoView.autoresizesSubviews = true
            
            self.loadingIndicator.isHidden = true
            self.avpController.player?.play()
            self.avpController.showsPlaybackControls = false
        }
    }
    
    func videoError() {
        let alert = UIAlertController(title: "Unexpected Error", message: "Unable to find the video, please select different asset.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))

        self.present(alert, animated: true)
    }
    
    @IBAction func playPauseButtonTap(sender: UIButton) {
        if self.avpController.player?.error == nil {
            if self.avpController.player?.rate != 0 {
                self.avpController.player?.pause()
                self.playPauseButton.isSelected = true
            }
            else {
                self.avpController.player?.play()
                self.playPauseButton.isSelected = false
            }
        }
        else {
            self.videoError()
        }
    }
    
    @IBAction func muteButtonTapped(sender: UIButton) {
        self.avpController.player?.isMuted = !self.avpController.player!.isMuted
        self.volumeButton.isSelected = !self.volumeButton.isSelected
    }
    
    @IBAction func onTapRewindButton(_ sender: UIButton) {
        if let currentTime = self.avpController.player?.currentTime() {
            var newTime = CMTimeGetSeconds(currentTime) - 10
            if newTime <= 0 {
                newTime = 0
            }
            self.avpController.player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        }
    }
    
    @IBAction func onTapForwardButton(_ sender: UIButton) {
        if let currentTime = self.avpController.player?.currentTime(), let duration = self.avpController.player?.currentItem?.duration {
            var newTime = CMTimeGetSeconds(currentTime) + 10
            if newTime >= CMTimeGetSeconds(duration) {
                newTime = CMTimeGetSeconds(duration)
            }
            self.avpController.player?.seek(to: CMTime(value: CMTimeValue(newTime * 1000), timescale: 1000))
        }
    }

}
