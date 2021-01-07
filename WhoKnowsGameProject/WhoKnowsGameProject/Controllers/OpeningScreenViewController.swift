//
//  ViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 6.01.2021.
//

import UIKit

class OpeningScreenViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var highScoreButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    fileprivate func prepareUI() {
        prepareViewsButtonsAndLabels()
        prepareNavigateBar()
    }
    
    fileprivate func prepareViewsButtonsAndLabels() {
        backgroundView.prepareComponentColor(0xDF8EFA)
        newGameButton.prepareComponentRadius(15)
        newGameButton.prepareComponentColor(0x61B846)
        newGameButton.prepareButtonName("New Game")
        highScoreButton.prepareComponentRadius(15)
        highScoreButton.prepareComponentColor(0xFF6179)
        highScoreButton.prepareButtonName("High Score")
        settingButton.prepareComponentRadius(15)
        settingButton.prepareComponentColor(0xFF6179)
        settingButton.prepareButtonName("Setting")
    }
    
    fileprivate func prepareNavigateBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func newGameButtonTouched() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newGameScreenViewController = storyboard.instantiateViewController(identifier: "NewGameScreenViewController") as! NewGameScreenViewController
        navigationController?.pushViewController(newGameScreenViewController, animated: true)
    }
    
    @IBAction func highScoreButtonTouched() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let highScoreScreenViewController = storyboard.instantiateViewController(identifier: "HighScoreScreenViewController") as! HighScoreScreenViewController
        navigationController?.pushViewController(highScoreScreenViewController, animated: true)
    }
    
    @IBAction func settingsButtonTouched() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsScreenViewController = storyboard.instantiateViewController(identifier: "SettingsScreenViewController") as! SettingsScreenViewController
        navigationController?.pushViewController(settingsScreenViewController, animated: true)
    }
}

