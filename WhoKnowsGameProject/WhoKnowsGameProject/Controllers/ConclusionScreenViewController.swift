//
//  ConclusionScreenViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 9.01.2021.
//

import UIKit

protocol TransportHighestScoresDelegate: class {
    func takePlayerDatas(highestplayers: [UserModel])
}

final class ConclusionScreenViewController: BaseViewController {
    
    @IBOutlet var backgroundView: BaseView!
    @IBOutlet weak var highScoreLogoView: UIImageView!
    
    @IBOutlet weak var categoryLabel: BaseLabel!
    @IBOutlet weak var difficultyLabel: BaseLabel!
    @IBOutlet weak var numberOfCorrectAnswerLabel: BaseLabel!
    @IBOutlet weak var pointLabel: BaseLabel!
    
    @IBOutlet weak var highscoreLogoButton: UIButton!
    @IBOutlet weak var goToHomeScreenButton: MenuButton!
    
    weak var delegate: TransportHighestScoresDelegate?
    
    var player = UserModel()
    var highestPlayers = [UserModel]()
    var trueAnswersCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        prepareInitialHighestScorers()
        calculateHighestScores()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getHighestPlayers()
    }
    
    fileprivate func prepareUI() {
        prepareLabelsAndButtonsName()
        highScoreLogoView.isHidden = true
    }
    
    fileprivate func prepareLabelsAndButtonsName() {
        categoryLabel.prepareLabelName("Category: \(player.selectedCategory.name ?? "")")
        difficultyLabel.prepareLabelName("Difficulty: \(player.selectedDifficulty?.capitalized ?? "")")
        numberOfCorrectAnswerLabel.prepareLabelName("Correct Answer: \(trueAnswersCount ?? 0)")
        pointLabel.prepareLabelName("Score: \(player.score)")
        goToHomeScreenButton.prepareButtonName("Go To Home Screen")
    }
    
    fileprivate func prepareInitialHighestScorers() {
        let berkin = UserModel()
        berkin.userName = "Berkin"
        berkin.score = 40
        berkin.selectedCategory.name = "General Knowledge"
        berkin.selectedCategory.id = 9
        berkin.selectedDifficulty = "Easy"
        
        let baris = UserModel()
        baris.userName = "Barış"
        baris.score = 10
        baris.selectedCategory.name = "General Knowledge"
        baris.selectedCategory.id = 9
        baris.selectedDifficulty = "Easy"
        
        let kaan = UserModel()
        kaan.userName = "Kaan"
        kaan.score = 30
        kaan.selectedCategory.name = "General Knowledge"
        kaan.selectedCategory.id = 9
        kaan.selectedDifficulty = "Easy"
        
        let ahmet = UserModel()
        ahmet.userName = "Ahmet"
        ahmet.score = 25
        ahmet.selectedCategory.name = "General Knowledge"
        ahmet.selectedCategory.id = 9
        ahmet.selectedDifficulty = "Easy"
        
        let hakan = UserModel()
        hakan.userName = "Hakan"
        hakan.score = 0
        hakan.selectedCategory.name = "General Knowledge"
        hakan.selectedCategory.id = 9
        hakan.selectedDifficulty = "Medium"
        
        highestPlayers.append(berkin)
        highestPlayers.append(baris)
        highestPlayers.append(kaan)
        highestPlayers.append(ahmet)
        highestPlayers.append(hakan)
    }
    
    fileprivate func calculateHighestScores () {
        highestPlayers.sort(by: {$0.score > $1.score})
        if player.score > highestPlayers.last?.score ?? 0 {
            highestPlayers.removeLast()
            highestPlayers.append(player)
            highestPlayers.sort(by: {$0.score > $1.score})
            highScoreLogoView.isHidden = false
        }
        saveHighestPlayers()
    }
    
    @IBAction func highscoreLogoButtonTouched(_ sender: Any) {
        highscoreAlert()
    }
    
    fileprivate func saveHighestPlayers() {
        let encoder = JSONEncoder()
        let savedPlayers = try! encoder.encode(highestPlayers)
        UserDefaults.standard.set(savedPlayers, forKey: "key")
    }
    
    fileprivate func getHighestPlayers() {
        if let userDatas = UserDefaults.standard.data(forKey: "key") {
            let decoder = JSONDecoder()
            let savedPlayers = try! decoder.decode([UserModel].self, from: userDatas)
            highestPlayers = savedPlayers
        }
    }
    
    fileprivate func highscoreAlert() {
        let alertHighscore = UIAlertController(title: "You achieved platinium badge!", message: "Wow! You are smart \n Your score is one of the highest scores", preferredStyle: .actionSheet)
        self.present(alertHighscore, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5){
            alertHighscore.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func goToHomeScreenButtonTouched(_ sender: Any) {
        self.delegate?.takePlayerDatas(highestplayers: highestPlayers)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let openingScreenViewController = storyboard.instantiateViewController(identifier: "OpeningScreenViewController") as! OpeningScreenViewController
        navigationController?.pushViewController(openingScreenViewController, animated: true)
    }
}
