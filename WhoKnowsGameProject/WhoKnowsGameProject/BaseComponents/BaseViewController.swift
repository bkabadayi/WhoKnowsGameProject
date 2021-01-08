//
//  BaseViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func prepareNavigateBar() {
        navigationController?.isNavigationBarHidden = true
    }
}
