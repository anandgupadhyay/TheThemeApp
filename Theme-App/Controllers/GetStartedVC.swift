//
//  ViewController.swift
//  Theme-App
//
//  Created by Anand Upadhyay on 03/01/24.
//

import UIKit
import Kingfisher

class GetStartedVC: UIViewController {
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var titleView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBgImg()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleView.layer.cornerRadius = 28
    }

    
    @IBAction func getStartedTapped(_ sender: UIButton) {

    }
    
    
    func setBgImg() {
        let rawUrl = K.defaultBg
        
        guard let imgURL = URL(string: rawUrl) else { return }
        // fetching image and displaying it using KingFisher dependency
        bgImg.kf.setImage(with: imgURL)

        // storing url in userDefaults
        let usrDefault = UserDefaults.standard
        usrDefault.setValue(rawUrl, forKey: "CurrentBg")
    }

}

