//
//  VideoLauncher.swift
//  Youtube
//
//  Created by vinay shinde on 15/06/18.
//  Copyright © 2018 vinay shinde. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView{
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    var pausePlayButton: UIButton = {
       let button = UIButton()
       button.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        button.tintColor = .white
        button.isHidden = true
       return button
    }()
    
    var isPlaying = false
    
    @objc func handlePlayPause() {
        if isPlaying{
            player?.pause()
            pausePlayButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }else{
            player?.play()
            pausePlayButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
    }
    
    let controlsContainerView: UIView = {
       let ccv = UIView()
        ccv.backgroundColor = UIColor(white: 0, alpha: 1)
        return ccv
    }()
    
    
    let currentTimeLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let videoLengthLabel: UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    let videoSlider: UISlider = {
        let sld = UISlider()
        sld.translatesAutoresizingMaskIntoConstraints = false
        sld.minimumTrackTintColor = .red
        sld.maximumTrackTintColor = .white
        sld.setThumbImage(#imageLiteral(resourceName: "circle-16"), for: .normal)
        sld.addTarget(self, action: #selector(handleSlider), for: .touchUpInside)
        return sld
    }()
    
    @objc func handleSlider()
    {
        guard let duration = player?.currentItem?.duration else {
            return
        }
        let totalSeconds = CMTimeGetSeconds(duration)
        let value = Float64(videoSlider.value) * totalSeconds
        let seekTime = CMTime(value: Int64(value), timescale: 1)
        player?.seek(to: seekTime) 
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    
        setupPlayer()
        setupGradientLayer()
        
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        controlsContainerView.addSubview(currentTimeLable)
        currentTimeLable.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLable.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        currentTimeLable.widthAnchor.constraint(equalToConstant: 60).isActive = true
        currentTimeLable.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLable.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    var player: AVPlayer?
    
    private func setupPlayer()  {
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        if let url = URL(string: urlString)
        {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            isPlaying = true
            
            //track player progress
            let interval = CMTime(value: 1, timescale: 1)
            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
                //somecode
                let seconds = CMTimeGetSeconds(progressTime)
                let secondString = String(format: "%02d", Int(seconds) % 60)
                let minuteString = String(format: "%02d", Int(seconds) / 60)
                self.currentTimeLable.text = "\(minuteString):\(secondString)"
                
                //Slider Movement
                if let duration = self.player?.currentItem?.duration{
                    let durationSeconds = CMTimeGetSeconds(duration)
                    
                    self.videoSlider.value = Float(seconds / durationSeconds)
                }
            })
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "currentItem.loadedTimeRanges"{
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            
            guard let duration = player?.currentItem?.duration else { return }
            let totalSeconds = CMTimeGetSeconds(duration)
            let secondsText = Int(totalSeconds) % 60
            let minutesText = String(format: "%02d", Int(totalSeconds) / 60 )
            videoLengthLabel.text = "\(minutesText):\(secondsText)"
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal Error")
    }
}

class VideoLauncher: NSObject {
    
    func launchVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            
            let height = keyWindow.frame.width * (9/16)
            let videoPlayerView = VideoPlayerView(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height))
            
            let frame = CGRect(x: keyWindow.frame.width, y: keyWindow.frame.height, width: 10, height: 10)
            let view = UIView(frame: frame)
            view.backgroundColor = .white
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completed) in
                //somecode
                UIApplication.shared.isStatusBarHidden = true
            })
            keyWindow.addSubview(view)
            view.addSubview(videoPlayerView)
        }
    }
    
}
