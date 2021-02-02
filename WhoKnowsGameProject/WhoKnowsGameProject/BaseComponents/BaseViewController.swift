//
//  BaseViewController.swift
//  WhoKnowsGameProject
//
//  Created by Berkin KABADAYI on 7.01.2021.
//

import UIKit
import AVFoundation

class BaseViewController: UIViewController {
    var activityView : UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    
    var darkBlur = UIBlurEffect()
    var blurView = UIVisualEffectView()
    
    func prepareNavigateBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addActivityIndicator()
    }
    
    func blurredBackground() {
        darkBlur = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialLight)
        blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = view.bounds
        view.addSubview(blurView)
    }
    
    func addActivityIndicator() {
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        activityView.color = .black
        activityView.style = UIActivityIndicatorView.Style.large
        view.addSubview(activityView)
    }
    
    func disableBlur() {
        blurView.removeFromSuperview()
    }
}

