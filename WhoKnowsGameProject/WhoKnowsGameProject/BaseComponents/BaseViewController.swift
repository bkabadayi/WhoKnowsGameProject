//
//  BaseViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit
import AVFoundation

class BaseViewController: UIViewController {
    
    func prepareNavigateBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !BackgroundMusic.shared.getPlayerStatus() {
            BackgroundMusic.shared.prepareBackgroundMusic()
        }
    }
    
//    func prepareBackgroundMusic() {
//        if BackgroundMusic.shared.isMusicOn {
//            let music = BackgroundMusic.shared.musicName
//            let url = Bundle.main.path(forResource: music, ofType: "mp3")
//            
//            do {
//                try AVAudioSession.sharedInstance().setMode(.default)
//                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
//                
//                guard let url = url else {
//                    return
//                }
//                
//                musicPlayer = try AVAudioPlayer(contentsOf: URL(string: url)!)
//                
//                guard let musicPlayer = musicPlayer else {
//                    return
//                }
//                musicPlayer.play()
//            }
//            catch {
//                print("Music error occured.")
//            }
//        } else {
//            musicPlayer?.pause()
//        }
//    }
}

