//
//  UIViewExtension.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 6.01.2021.
//

import UIKit

extension UIView {
    func prepareComponentRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func prepareComponentColor(_ hexValue: UInt) {
        self.backgroundColor =  UIColor(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                                        green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
                                        blue: CGFloat(hexValue & 0x0000FF) / 255.0,
                                        alpha: CGFloat(1.0)
                                        )
    }
}
