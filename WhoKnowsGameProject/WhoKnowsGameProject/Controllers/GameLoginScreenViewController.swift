//
//  NewGameScreenViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit
import Alamofire

final class GameLoginScreenViewController: BaseViewController {
    
    @IBOutlet var backgroundView: BaseView!
    
    @IBOutlet weak var categoryLabel: BaseLabel!
    @IBOutlet weak var difficultyLabel: BaseLabel!
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var difficultyPickerView: UIPickerView!
    
    @IBOutlet weak var nameEntranceTextField: UITextField!
    
    @IBOutlet weak var startButton: GoToGameButton!
    
    var player = UserModel()
    var pickerCategoryData = TriviaCategoryModel()
    var pickerDifficultyData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    fileprivate func prepareUI() {
        prepareLabelsAndButtonsName()
        preparePickerViews()
    }
    
    fileprivate func prepareLabelsAndButtonsName() {
        categoryLabel.prepareLabelName("Category")
        difficultyLabel.prepareLabelName("Difficulty")
        
        startButton.prepareButtonName("START")
    }
    
    fileprivate func preparePickerViews() {
        categoryPickerView.tag = 1
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        getCategoryData()
        
        difficultyPickerView.tag = 2
        difficultyPickerView.delegate = self
        difficultyPickerView.dataSource = self
        pickerDifficultyData.append("easy")
        pickerDifficultyData.append("medium")
        pickerDifficultyData.append("hard")
    }
    
    fileprivate func setNameData() {
        if nameEntranceTextField.text != "" {                               // "nameEntranceTextField.text != nil" neden olmuyor
            player.userName = nameEntranceTextField.text
        }
        else {
            let nameAlert = UIAlertController(title: "You didn't enter your name", message: "You should enter your name before the game starts!", preferredStyle: .alert)
            nameAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(nameAlert, animated: true)
        }
    }
    
    fileprivate func getCategoryData() {
        AF.request("https://opentdb.com/api_category.php").responseJSON { response in
            if let categoryData = response.data {
                let categoryList = try! JSONDecoder().decode(TriviaCategoryModel.self, from: categoryData)
                self.pickerCategoryData = categoryList
                self.categoryPickerView.reloadAllComponents()
            }
        }
    }
    
    @IBAction func startButtonTouched() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gamePlayScreenViewController = storyboard.instantiateViewController(identifier: "GamePlayScreenViewController") as! GamePlayScreenViewController
        setNameData()
        gamePlayScreenViewController.player.userName = player.userName
        gamePlayScreenViewController.player.selectedCategory = player.selectedCategory
        gamePlayScreenViewController.player.selectedDifficulty = player.selectedDifficulty
        navigationController?.pushViewController(gamePlayScreenViewController, animated: true)
    }
}

extension GameLoginScreenViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return pickerCategoryData.trivia_categories.count
        }
        else if pickerView.tag == 2 {
            return pickerDifficultyData.count
        }
        else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            player.selectedCategory = pickerCategoryData.trivia_categories[row]
        }
        else if pickerView.tag == 2 {
            player.selectedDifficulty = pickerDifficultyData[row]
        }
    }
}

extension GameLoginScreenViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return pickerCategoryData.trivia_categories[row].name
        }
        else if pickerView.tag == 2 {
            return pickerDifficultyData[row].capitalized
        }
        else {
            return ""
        }
    }
}
