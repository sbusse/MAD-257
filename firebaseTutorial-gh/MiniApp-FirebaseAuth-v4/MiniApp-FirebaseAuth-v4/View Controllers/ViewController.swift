//
//  ViewController.swift
//  MiniApp-FirebaseAuth-v4
//
//  Created by student on 9/23/20.
//  Copyright © 2020 MAD 257. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    
    var videoPlayerLayer:AVPlayerLayer?
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
            setUpElements()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // set up video in the background
        setUpVideo()
    }
        
        func setUpElements() {
            
            //style the elements
            Utilities.styleFilledButton(signUpButton)
            Utilities.styleHollowButton(loginButton)
            
    }
    
    func setUpVideo() {
        
        //get the path to the resource in the bundle
        let bundlePath = Bundle.main.path(forResource: "video", ofType: "mp4")
        
        guard bundlePath != nil else {
            return
        }
        //create a url from it
        
        let url = URL(fileURLWithPath: bundlePath!)
        
        //create the video player item
        let item = AVPlayerItem(url: url)
        
        //create the player
        videoPlayer = AVPlayer(playerItem: item)
        
        //create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //adjust the size and frame
//        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        
        videoPlayerLayer?.frame = CGRect(x: 0, y: -200, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        
        //add it to the view and play it
        videoPlayer?.playImmediately(atRate: 0.3)
        
    }


}

