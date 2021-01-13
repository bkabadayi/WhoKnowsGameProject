//
//  HighScoreScreenViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit
import Foundation

final class HighScoreScreenViewController: BaseViewController, TransportHighestScoresDelegate {
    
    @IBOutlet var backgroundView: BaseView!
    
    @IBOutlet weak var highscoreLabel: BaseLabel!
    
    @IBOutlet weak var infoNameLabel: UILabel!
    @IBOutlet weak var infoScoreLabel: UILabel!
    @IBOutlet weak var infoDifficultyLabel: UILabel!
    
    @IBOutlet weak var firstUserNameLabel: UILabel!
    @IBOutlet weak var secondUserNameLabel: UILabel!
    @IBOutlet weak var thirdUserNameLabel: UILabel!
    @IBOutlet weak var fourthUserNameLabel: UILabel!
    @IBOutlet weak var fifthUserNameLabel: UILabel!
    
    @IBOutlet weak var firstUserScoreLabel: UILabel!
    @IBOutlet weak var secondUserScoreLabel: UILabel!
    @IBOutlet weak var thirdUserScoreLabel: UILabel!
    @IBOutlet weak var fourthUserScoreLabel: UILabel!
    @IBOutlet weak var fifthUserScoreLabel: UILabel!
    
    @IBOutlet weak var firstUserDifficultyLabel: UILabel!
    @IBOutlet weak var secondUserDifficultyLabel: UILabel!
    @IBOutlet weak var thirdUserDifficultyLabel: UILabel!
    @IBOutlet weak var fourthUserDifficultyLabel: UILabel!
    @IBOutlet weak var fifthUserDifficultyLabel: UILabel!
    
    var firstUser = UserModel()
    var secondUser = UserModel()
    var thirdUser = UserModel()
    var fourthUser = UserModel()
    var fifthUser = UserModel()
    
    var playerDatas = [UserModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshLabels()
    }
    
    fileprivate func prepareUI() {
        prepareLabels()
    }
    
    fileprivate func prepareLabels() {
        highscoreLabel.prepareLabelName("HIGH SCORES")
        infoNameLabel.prepareLabelName("Name")
        infoScoreLabel.prepareLabelName("Score")
        infoDifficultyLabel.prepareLabelName("Difficulty")
    }
    
    fileprivate func refreshLabels() {
        if let userDatas = UserDefaults.standard.data(forKey: "key") {
            let decoder = JSONDecoder()
            let savedPlayers = try! decoder.decode([UserModel].self, from: userDatas)
            takePlayerDatas(highestplayers: savedPlayers)
        }
    }
    func takePlayerDatas(highestplayers: [UserModel]) {
        firstUser = highestplayers[0]
        secondUser = highestplayers[1]
        thirdUser = highestplayers[2]
        fourthUser = highestplayers[3]
        fifthUser = highestplayers[4]
        
        firstUserNameLabel.prepareLabelName("\(firstUser.userName ?? "")")
        firstUserScoreLabel.prepareLabelName("\(firstUser.score)")
        firstUserDifficultyLabel.prepareLabelName("\(firstUser.selectedDifficulty?.capitalized ?? "")")
        
        secondUserNameLabel.prepareLabelName("\(secondUser.userName ?? "")")
        secondUserScoreLabel.prepareLabelName("\(secondUser.score)")
        secondUserDifficultyLabel.prepareLabelName("\(secondUser.selectedDifficulty?.capitalized ?? "")")
        
        thirdUserNameLabel.prepareLabelName("\(thirdUser.userName ?? "")")
        thirdUserScoreLabel.prepareLabelName("\(thirdUser.score)")
        thirdUserDifficultyLabel.prepareLabelName("\(thirdUser.selectedDifficulty?.capitalized ?? "")")
        
        fourthUserNameLabel.prepareLabelName("\(fourthUser.userName ?? "")")
        fourthUserScoreLabel.prepareLabelName("\(fourthUser.score)")
        fourthUserDifficultyLabel.prepareLabelName("\(fourthUser.selectedDifficulty?.capitalized ?? "")")
        
        fifthUserNameLabel.prepareLabelName("\(fifthUser.userName ?? "")")
        fifthUserScoreLabel.prepareLabelName("\(fifthUser.score)")
        fifthUserDifficultyLabel.prepareLabelName("\(fifthUser.selectedDifficulty?.capitalized ?? "")")
    }
}
