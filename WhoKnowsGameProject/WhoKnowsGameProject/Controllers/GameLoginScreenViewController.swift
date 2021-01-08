//
//  NewGameScreenViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit

class GameLoginScreenViewController: BaseViewController {
    
    @IBOutlet var backgroundView: BaseView!
    
    @IBOutlet weak var categoryLabel: BaseLabel!
    @IBOutlet weak var difficultyLabel: BaseLabel!
    
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var difficultyPickerView: UIPickerView!
    
    @IBOutlet weak var nameEntranceTextField: UITextField!
    
    @IBOutlet weak var startButton: GameButton!
    
    var pickerCategoryData: [String] = []
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
        categoryPickerView.delegate = self
        categoryPickerView.dataSource = self
        
        difficultyPickerView.delegate = self
        difficultyPickerView.dataSource = self
        
        categoryPickerView.tag = 1
        
        pickerCategoryData.append("Sports")
        pickerCategoryData.append("History")
        pickerCategoryData.append("Art")
        pickerCategoryData.append("Politics")
        
        difficultyPickerView.tag = 2
        
        pickerDifficultyData.append("Easy")
        pickerDifficultyData.append("Normal")
        pickerDifficultyData.append("Hard")
    }
//
//    @IBAction startButtonTouched() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//    }
}

extension GameLoginScreenViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return pickerCategoryData.count
        }
        else if pickerView.tag == 2 {
            return pickerDifficultyData.count
        }
        else {
            return 0
        }
    }
}

extension GameLoginScreenViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return pickerCategoryData[row]
        }
        else if pickerView.tag == 2 {
            return pickerDifficultyData[row]
        }
        else {
            return ""
        }
    }
}
