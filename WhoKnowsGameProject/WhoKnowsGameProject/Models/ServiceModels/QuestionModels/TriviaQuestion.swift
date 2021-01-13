//
//  TriviaQuestion.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 8.01.2021.
//

import Foundation

class TriviaQuestion: Codable {
    var category: String?
    var type: String?
    var difficulty: String?
    var question: String?
    var correct_answer: String?
    var incorrect_answers: [String] = []
}
