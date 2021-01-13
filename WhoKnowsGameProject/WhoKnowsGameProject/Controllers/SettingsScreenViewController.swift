//
//  SettingsScreenViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit

final class SettingsScreenViewController: BaseViewController {
    @IBOutlet var backgroundView: BaseView!
    
    @IBOutlet weak var backgroundMusicLabel: BaseLabel!
    
    @IBOutlet weak var resetDefaultButton: MenuButton!
    
    @IBOutlet weak var backgroundMusicSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareSwitchStatus()
    }
    
    fileprivate func prepareUI() {
        backgroundMusicLabel.prepareLabelName("Background Music")
        resetDefaultButton.prepareButtonName("Reset Defaults")
        navigationItem.title = "Settings"
    }
    
    fileprivate func prepareSwitchStatus() {
        if BackgroundMusicSwitchStatus.shared.isStatusOn {
            backgroundMusicSwitch.setOn(true, animated: true)
        }
        else {
            backgroundMusicSwitch.setOn(false, animated: true)
        }
    }
    
    @IBAction func backgroundMusicSwitched(_ sender: Any) {
        BackgroundMusic.shared.isMusicOn = backgroundMusicSwitch.isOn
        BackgroundMusicSwitchStatus.shared.isStatusOn = backgroundMusicSwitch.isOn
        BackgroundMusic.shared.prepareBackgroundMusic()
    }
    
    @IBAction func resetDefaultButtonTouched(_ sender: Any) {
        backgroundMusicSwitch.setOn(true, animated: true)
        BackgroundMusic.shared.isMusicOn = true
        BackgroundMusicSwitchStatus.shared.isStatusOn = true
        BackgroundMusic.shared.prepareBackgroundMusic()
        
    }
    
    
    
}
