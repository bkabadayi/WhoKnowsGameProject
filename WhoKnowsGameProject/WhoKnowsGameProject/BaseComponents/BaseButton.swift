//
//  BaseButton.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit

class BaseButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareComponentRadius(15)
    }
}
