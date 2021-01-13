//
//  TriviaQuestionModel.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 8.01.2021.
//

import Foundation

class TriviaQuestionModel: Codable {
    var response_code: Int?
    var results: [TriviaQuestion] = []
}
