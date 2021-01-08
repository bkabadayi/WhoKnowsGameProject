//
//  NewGameScreenViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit
import Alamofire

class GameLoginScreenViewController: BaseViewController {
    
    @IBOutlet var backgroundView: BaseView!
    
    @IBOutlet weak var categoryLabel: BaseLabel!
    @IBOutlet weak var difficultyLabel: BaseLabel!
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var difficultyPickerView: UIPickerView!
    
    @IBOutlet weak var nameEntranceTextField: UITextField!
    
    @IBOutlet weak var startButton: GameButton!
    
    var selectedCategory: Int?
    var selectedDifficulty: String?
    
    var pickerCategoryData = TriviaCategoryModel()
    var pickerDifficultyData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    fileprivate func prepareUI() {
        prepareViewsButtonsAndLabels()
        preparePickerViews()
        prepareNavigateBar()
    }
    
    fileprivate func prepareViewsButtonsAndLabels() {
        backgroundView.prepareView()
        
        categoryLabel.prepareLabel()
        categoryLabel.prepareLabelName("Category")
        
        difficultyLabel.prepareLabel()
        difficultyLabel.prepareLabelName("Difficulty")
        
        startButton.prepareButton()
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
        pickerDifficultyData.append("Easy")
        pickerDifficultyData.append("Medium")
        pickerDifficultyData.append("Hard")
    }
    
    func getCategoryData() {
        AF.request("https://opentdb.com/api_category.php").responseJSON { response in
            if let categoryData = response.data {
                let categoryList = try! JSONDecoder().decode(TriviaCategoryModel.self, from: categoryData)
                self.pickerCategoryData.trivia_categories = categoryList.trivia_categories
                self.categoryPickerView.reloadAllComponents()
            }
        }
    }

    @IBAction func startButtonTouched() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let gamePlayScreenViewController = storyboard.instantiateViewController(identifier: "GamePlayScreenViewController") as! GamePlayScreenViewController
        gamePlayScreenViewController.selectedCategory = selectedCategory
        gamePlayScreenViewController.selectedDifficulty = selectedDifficulty
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
            selectedCategory = pickerCategoryData.trivia_categories[row].id
        }
        else if pickerView.tag == 2 {
            selectedDifficulty = pickerDifficultyData[row]
        }
    }
}

extension GameLoginScreenViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return pickerCategoryData.trivia_categories[row].name
        }
        else if pickerView.tag == 2 {
            return pickerDifficultyData[row]
        }
        else {
            return ""
        }
    }
}
