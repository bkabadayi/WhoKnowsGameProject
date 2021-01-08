//
//  ViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 6.01.2021.
//

import UIKit

class OpeningScreenViewController: BaseViewController {

    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet var backgroundView: BaseView!
    
    @IBOutlet weak var newGameButton: GameButton!
    @IBOutlet weak var highScoreButton: BaseButton!
    @IBOutlet weak var settingsButton: BaseButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    fileprivate func prepareUI() {
        prepareViewsButtonsAndLabels()
        prepareNavigateBar()
    }
    
    fileprivate func prepareViewsButtonsAndLabels() {
        backgroundView.prepareView()
        newGameButton.prepareButton()
        newGameButton.prepareButtonName("New Game")
        highScoreButton.prepareButton()
        highScoreButton.prepareButtonName("High Score")
        settingsButton.prepareButton()
        settingsButton.prepareButtonName("Settings")
    }
    
    @IBAction func newGameButtonTouched() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newGameScreenViewController = storyboard.instantiateViewController(identifier: "NewGameScreenViewController") as! GameLoginScreenViewController
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

