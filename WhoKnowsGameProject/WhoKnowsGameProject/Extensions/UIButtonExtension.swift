//
//  UIButtonExtension.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import Foundation
import UIKit

extension UIButton {
    func prepareButtonName(_ text: String?) {
        self.setTitle(text, for: .normal)
    }
}

