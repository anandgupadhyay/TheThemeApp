//
//  ViewController.swift
//  Theme-App
//
//  Created by Anand Upadhyay on 03/01/24.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
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
//        let themeHomeVC = SkeletonViewController()
//        self.navigationController?.pushViewController(themeHomeVC, animated: true)
//        debugPrint("pressed")
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

//https://images.unsplash.com/photo-1704128728168-21b9f1381c17?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
//https://images.unsplash.com/photo-1703897059883-3b0e02522cdc?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
//https://images.unsplash.com/photo-1617298748161-f59f6096f130?q=80&w=2730&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
//image urls
//    https://images.unsplash.com/photo-1566198602184-30a482db864a?q=80&w=2773&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
//    https://images.unsplash.com/photo-1537204319452-fdbd29e2ccc7?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
//    https://images.unsplash.com/photo-1575722290270-626b0208df99?q=80&w=2432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
//    https://images.unsplash.com/photo-1541763029361-21b1788343db?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
//    https://images.unsplash.com/photo-1583418007992-a8e33a92e7ad?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
//    https://images.unsplash.com/photo-1533035353720-f1c6a75cd8ab?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
//    https://images.unsplash.com/photo-1528459105426-b9548367069b?q=80&w=2764&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
//
