//
//  ViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 6.01.2021.
//

import UIKit

final class OpeningScreenViewController: BaseViewController {

    @IBOutlet var backgroundView: BaseView!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var newGameButton: GoToGameButton!
    
    @IBOutlet weak var highScoreButton: BaseButton!
    @IBOutlet weak var settingsButton: BaseButton!
    
    @IBOutlet weak var gameInfoButton: UIButton!
    
    @IBOutlet weak var gameInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        prepareBackgroundMusic()
//    }
    
    fileprivate func prepareUI() {
        prepareLabelsAndButtonsName()
    }
    
    fileprivate func prepareLabelsAndButtonsName() {
        newGameButton.prepareButtonName("New Game")
        highScoreButton.prepareButtonName("High Score")
        settingsButton.prepareButtonName("Settings")
        gameInfoLabel.prepareLabelName("about game")
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
    
    @IBAction func gameInfoButtonTouched(_ sender: Any) {
        let gameInfoAlert = UIAlertController(title: "WHO'S KNOW?", message:
                                                "'Who's Know' is a general culture game. You answer multiple-choice questions based on the category and difficulty level you choose. Each correct answer is 5 points at the easy level, 10 points at the medium level and 20 points at the hard level. If you want to see the highest scores, press 'Highest Score' button. Good luck!", preferredStyle: .actionSheet)
        gameInfoAlert.addAction(UIAlertAction(title: "Got it!", style: .cancel, handler: nil))
        self.present(gameInfoAlert, animated: true)
    }
}

