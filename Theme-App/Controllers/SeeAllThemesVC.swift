//
//  AllThemesViewController.swift
//  Theme-App
//
//  Created by Anand Upadhyay on 03/01/24.
//

import UIKit
import Kingfisher

class SeeAllThemesVC: UIViewController {

    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var themeCollection: UICollectionView!
    
    var titleText = ""
    var imgIndex = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBgFromUsrDefault()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        customNavBar()
    }
    

    func setBgFromUsrDefault() {
        //to get the saved background image url 9 Jan 2024
        if let bgUrl = UserDefaults.standard.string(forKey: UserDefaultKeys.appBackgorundImageUrl.rawValue) {
            backgroundURL = bgUrl
        }
        
        if backgroundURL != nil{
            self.fetchPassBackgroundImage(imageUrl: backgroundURL!)
        }else{
            
        }
    }
    
    func fetchPassBackgroundImage(imageUrl: String) {
        
        //Added on 22 Nov by SANDREW
        guard let url = URL.init(string: imageUrl) else {
            return
        }
        let resource = KF.ImageResource(downloadURL: url, cacheKey: imageUrl)
        bgImg.kf.setImage(with: resource)
        
    }
    
    func customNavBar() {
        
        let customNavigationBar: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        view.addSubview(customNavigationBar)
        
        let backBtn = UIButton()
//        backBtn.backgroundColor = .clear
//        backBtn.layer.borderColor =  UIColor.white.cgColor
//        backBtn.layer.borderWidth = 1.5
//        backBtn.layer.cornerRadius = 10
//        backBtn.setTitle("BACK", for: .normal)
        backBtn.setBackButtonCornerAndBorder()
        backBtn.setTitle("BACK", for: .normal)

        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        customNavigationBar.addSubview(backBtn)
        
        // Heading of screen
        let titleLabel = UILabel()
        titleLabel.text = "\(titleText) Themes"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = ColorHandlerSinglton.shared.currentSelectedColorForAPPTitle

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        customNavigationBar.addSubview(titleLabel)
        
        //  All constraints
        NSLayoutConstraint.activate([
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 44),
            
            titleLabel.centerXAnchor.constraint(equalTo: customNavigationBar.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor),
            
            backBtn.leadingAnchor.constraint(equalTo: customNavigationBar.leadingAnchor, constant: 16),
            backBtn.centerYAnchor.constraint(equalTo: customNavigationBar.centerYAnchor),
            backBtn.widthAnchor.constraint(equalToConstant: 60),
            backBtn.heightAnchor.constraint(equalToConstant: 20),
        ])
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.selectedThemeSegue {
            let destVC = segue.destination as! SelectedThemeVC
            destVC.selectedWallpaper = imgIndex
        }
    }
    
    
    @objc func backBtnTapped(sender: UIButton)  {
        navigationController?.popViewController(animated: true)
    }
    
}


extension SeeAllThemesVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.seeAllCollectionCellIdentifier, for: indexPath) as! SeeAllCell
        cell.collectionImg.kf.indicatorType = .activity
        cell.collectionImg.layer.cornerRadius = 25
        cell.collectionImg.layer.masksToBounds = true
        cell.collectionImg.kf.setImage(with: URL(string: K.imgUrl1))//, placeholder: UIImage(named: "placeholder"))
        cell.lblName.text = "Theme Name"
        cell.lblName.textColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/2 - 20 , height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        imgIndex = indexPath.section
        performSegue(withIdentifier: K.selectedThemeSegue, sender: self)
    }
}
