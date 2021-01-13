//
//  BackgroundMusic.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 11.01.2021.
//

import Foundation
import AVFoundation

class BackgroundMusic {
    static let shared = BackgroundMusic()

    var musicName: String = "backgroundmusic"
    var isMusicOn: Bool = true
    var musicPlayer: AVAudioPlayer?
    
    func prepareBackgroundMusic() {
        if BackgroundMusic.shared.isMusicOn {
            let music = BackgroundMusic.shared.musicName
            let url = Bundle.main.path(forResource: music, ofType: "mp3")

            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

                guard let url = url else {
                    return
                }

                musicPlayer = try AVAudioPlayer(contentsOf: URL(string: url)!)

                guard let musicPlayer = musicPlayer else {
                    return
                }
                musicPlayer.play()
            }
            catch {
                print("Music error occured.")
            }
        }
        else {
            musicPlayer?.pause()
        }
    }
    
    func getPlayerStatus() -> Bool {
        return musicPlayer?.isPlaying ?? false
    }
}
