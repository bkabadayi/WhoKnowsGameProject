//
//  GamePlayScreenViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit
import Alamofire

final class GamePlayScreenViewController: BaseViewController {
    @IBOutlet var backgroundView: BaseView!
    
    @IBOutlet weak var categoryLabel: BaseLabel!
    @IBOutlet weak var difficultyLabel: BaseLabel!
    @IBOutlet weak var questionNumberLabel: BaseLabel!
    @IBOutlet weak var questionLabel: BaseLabel!
    
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var upLeftButton: InGameButton!
    @IBOutlet weak var upRightButton: InGameButton!
    @IBOutlet weak var downLeftButton: InGameButton!
    @IBOutlet weak var downRightButton: InGameButton!
    
    var player = UserModel()
    
    var question = TriviaQuestionModel()
    var questionCounter = 1
    
    var randomNumber: Int?
    var timeLeft: Int = 25
    
    var gameTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        startGameTimer()
    }
    
    fileprivate func prepareUI() {
        prepareLabelsAndButtonsName()
    }
    
    fileprivate func prepareLabelsAndButtonsName() {
        categoryLabel.prepareLabelName(player.selectedCategory.name)
        difficultyLabel.prepareLabelName(player.selectedDifficulty?.capitalized)
        questionNumberLabel.prepareLabelName("Question #\(questionCounter)")
        getQuestionData()
        pointLabel.prepareLabelName("Point: \(player.score)")
        timeLabel.prepareLabelName("\(timeLeft)")
    }
    
    fileprivate func getQuestionData() {
//        activityView.startAnimating()
//        blurredBackground()
        AF.request("https://opentdb.com/api.php?amount=1&category=\(player.selectedCategory.id ?? 0)&difficulty=\(player.selectedDifficulty ?? "")&type=multiple").responseJSON { response in
            if let questionData = response.data {
                let apiQuestion = try! JSONDecoder().decode(TriviaQuestionModel.self, from: questionData)
                self.question = apiQuestion
//                self.disableBlur()
//                self.activityView.stopAnimating()
                self.questionLabel.prepareLabelName(self.question.results[0].question)
                self.questionLabel.reloadInputViews()
                self.prepareAllButtonsName()
            }
        }
    }
    
    fileprivate func prepareAllButtonsName() {
        randomNumber = randomGenerator()
        setButtonTags()
        
        if randomNumber == upLeftButton.tag {
            upLeftButton.prepareButtonName(question.results[0].correct_answer)
            upRightButton.prepareButtonName(question.results[0].incorrect_answers[0])
            downLeftButton.prepareButtonName(question.results[0].incorrect_answers[1])
            downRightButton.prepareButtonName(question.results[0].incorrect_answers[2])
        }
        
        if randomNumber == upRightButton.tag {
            upLeftButton.prepareButtonName(question.results[0].incorrect_answers[0])
            upRightButton.prepareButtonName(question.results[0].correct_answer)
            downLeftButton.prepareButtonName(question.results[0].incorrect_answers[1])
            downRightButton.prepareButtonName(question.results[0].incorrect_answers[2])
        }
        
        if randomNumber == downLeftButton.tag {
            upLeftButton.prepareButtonName(question.results[0].incorrect_answers[0])
            upRightButton.prepareButtonName(question.results[0].incorrect_answers[1])
            downLeftButton.prepareButtonName(question.results[0].correct_answer)
            downRightButton.prepareButtonName(question.results[0].incorrect_answers[2])
        }
        
        if randomNumber == downRightButton.tag {
            upLeftButton.prepareButtonName(question.results[0].incorrect_answers[0])
            upRightButton.prepareButtonName(question.results[0].incorrect_answers[1])
            downLeftButton.prepareButtonName(question.results[0].incorrect_answers[2])
            downRightButton.prepareButtonName(question.results[0].correct_answer)
        }
    }
    
    fileprivate func setButtonTags() {
        upLeftButton.tag = 1
        upRightButton.tag = 2
        downLeftButton.tag = 3
        downRightButton.tag = 4
    }
    
    fileprivate func randomGenerator() -> Int {
        return Int.random(in: 1...4)
    }
    
    fileprivate func calculatePoint() {
        if player.selectedDifficulty == "easy" {
            player.score += 5
        }
        
        if player.selectedDifficulty == "medium" {
            player.score += 10
        }
        
        if player.selectedDifficulty == "hard" {
            player.score += 20
        }
    }
    fileprivate func startGameTimer() {
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timeLeft > -1 {
                if self.timeLeft <= 5 {
                    self.timeLabel.textColor = .red
                    self.timeLabel.prepareLabelName("\(self.timeLeft)")
                }
                self.timeLabel.prepareLabelName("\(self.timeLeft)")
                self.timeLeft -= 1
            } else {
                self.gameTimer?.invalidate()
                self.whenGameTimeEnds()
            }
        }
    }
    
    fileprivate func refreshGameInfos() {
        questionCounter += 1
        timeLeft = 25
        calculatePoint()
        questionNumberLabel.prepareLabelName("Question #\(questionCounter)")
        pointLabel.prepareLabelName("Point: \(player.score)")
        getQuestionData()
    }
    
    @IBAction func upLeftButtonTouched(_ sender: Any) {
        areButtonsEnabled(false)
        upLeftButton.prepareComponentBackgroundColor(0xAEAEB2)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if self.randomNumber == self.upLeftButton.tag {
                self.upLeftButton.prepareComponentBackgroundColor(0x12FF05)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.upLeftButton.prepareComponentBackgroundColor(0xFFE00E)
                    self.refreshGameInfos()
                    self.areButtonsEnabled(true)
                }
            }
            
            else {
                self.upLeftButton.prepareComponentBackgroundColor(0xFF3824)
                
                if self.randomNumber == self.upRightButton.tag {
                    self.upRightButton.prepareComponentBackgroundColor(0x12FF05)
                }
                
                if self.randomNumber == self.downLeftButton.tag {
                    self.downLeftButton.prepareComponentBackgroundColor(0x12FF05)
                }
                
                if self.randomNumber == self.downRightButton.tag {
                    self.downRightButton.prepareComponentBackgroundColor(0x12FF05)
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.gameTimer?.invalidate()
                    self.goToConclusionScreen()
                }
            }
        }
    }
    @IBAction func upRightButtonTouched(_ sender: Any) {
        areButtonsEnabled(false)
        upRightButton.prepareComponentBackgroundColor(0xAEAEB2)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if self.randomNumber == self.upRightButton.tag {
                self.upRightButton.prepareComponentBackgroundColor(0x12FF05)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.upRightButton.prepareComponentBackgroundColor(0xFFE00E)
                    self.refreshGameInfos()
                    self.areButtonsEnabled(false)
                }
            }
            
            else {
                self.upRightButton.prepareComponentBackgroundColor(0xFF3824)
                
                if self.randomNumber == self.upLeftButton.tag {
                    self.upLeftButton.prepareComponentBackgroundColor(0x12FF05)
                }
                
                if self.randomNumber == self.downLeftButton.tag {
                    self.downLeftButton.prepareComponentBackgroundColor(0x12FF05)
                }
                
                if self.randomNumber == self.downRightButton.tag {
                    self.downRightButton.prepareComponentBackgroundColor(0x12FF05)
                }
                self.gameTimer?.invalidate()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.gameTimer?.invalidate()
                    self.goToConclusionScreen()
                }
            }
        }
    }
    @IBAction func downLeftButtonTouched(_ sender: Any) {
        areButtonsEnabled(false)
        downLeftButton.prepareComponentBackgroundColor(0xAEAEB2)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if self.randomNumber == self.downLeftButton.tag {
                self.downLeftButton.prepareComponentBackgroundColor(0x12FF05)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.downLeftButton.prepareComponentBackgroundColor(0xFFE00E)
                    self.refreshGameInfos()
                    self.areButtonsEnabled(true)
                }
            }
            
            else {
                self.downLeftButton.prepareComponentBackgroundColor(0xFF3824)
                
                if self.randomNumber == self.upRightButton.tag {
                    self.upRightButton.prepareComponentBackgroundColor(0x12FF05)
                }
                
                if self.randomNumber == self.upLeftButton.tag {
                    self.upLeftButton.prepareComponentBackgroundColor(0x12FF05)
                }
                
                if self.randomNumber == self.downRightButton.tag {
                    self.downRightButton.prepareComponentBackgroundColor(0x12FF05)
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.gameTimer?.invalidate()
                    self.goToConclusionScreen()
                }
            }
        }
    }
    
    @IBAction func downRightButtonTouched(_ sender: Any) {
        areButtonsEnabled(false)
        downRightButton.prepareComponentBackgroundColor(0xAEAEB2)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            if self.randomNumber == self.downRightButton.tag {
                self.downRightButton.prepareComponentBackgroundColor(0x12FF05)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.downRightButton.prepareComponentBackgroundColor(0xFFE00E)
                    self.refreshGameInfos()
                    self.areButtonsEnabled(true)
                }
            }
            
            else {
                self.downRightButton.prepareComponentBackgroundColor(0xFF3824)
                
                if self.randomNumber == self.upRightButton.tag {
                    self.upRightButton.prepareComponentBackgroundColor(0x12FF05)
                }
                
                if self.randomNumber == self.upLeftButton.tag {
                    self.upLeftButton.prepareComponentBackgroundColor(0x12FF05)
                }
                
                if self.randomNumber == self.downLeftButton.tag {
                    self.downLeftButton.prepareComponentBackgroundColor(0x12FF05)
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.gameTimer?.invalidate()
                    self.goToConclusionScreen()
                }
            }
        }
    }
    
    fileprivate func areButtonsEnabled(_ status: Bool) {
        upLeftButton.isEnabled = status
        upRightButton.isEnabled = status
        downLeftButton.isEnabled = status
        downRightButton.isEnabled = status
    }
    
    fileprivate func whenGameTimeEnds() {
        let alertTime = UIAlertController(title: "Time's up!", message: " Number of correct answers: \(questionCounter - 1) \n Your point: \(player.score)", preferredStyle: .alert)
        alertTime.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.goToConclusionScreen()}))
        self.present(alertTime, animated: true)
    }
    
    fileprivate func goToConclusionScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let conclusionScreenViewController = storyboard.instantiateViewController(identifier: "ConclusionScreenViewController") as! ConclusionScreenViewController
        conclusionScreenViewController.trueAnswersCount = questionCounter - 1
        conclusionScreenViewController.player = player
        navigationController?.pushViewController(conclusionScreenViewController, animated: true)
    }
}
