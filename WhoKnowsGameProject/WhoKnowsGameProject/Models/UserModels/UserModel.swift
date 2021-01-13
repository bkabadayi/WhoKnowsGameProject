//
//  UserModel.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 10.01.2021.
//

import Foundation

class UserModel: Codable {
    var userName: String?
    var selectedCategory = TriviaCategory()
    var selectedDifficulty: String?
    var score: Int = 0
}
