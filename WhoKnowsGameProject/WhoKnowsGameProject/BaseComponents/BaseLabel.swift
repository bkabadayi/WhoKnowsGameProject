//
//  BaseLabel.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit

class BaseLabel: UILabel {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareComponentRadius(15)
        prepareComponentBackgroundColor(0x6E00E2)
    }
}
