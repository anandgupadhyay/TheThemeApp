//
//  SkeletonViewController.swift
//  Theme-App
//
//  Created by Anand Upadhyay on 03/01/24.
//

import UIKit
import Kingfisher

class ThemeStoreVC: UIViewController, selectedWallpaperDelegate {
    

    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var homeTable: UITableView!
    
    var sectionTitles = ["Best Selling", "New Year", "Movies", "Traditional", "Trending", "Graphic", "Premium", "Free"]
    var currentSection = 0
    var tappedWallpaper = 0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBgFromUsrDefault()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        customNavBar()
        
        if #available(iOS 15.0, *) {
            homeTable.sectionHeaderTopPadding = 20
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    func setBgFromUsrDefault() {
        // fetching stored url from userDefaults
        let usrDefault = UserDefaults.standard
        let rawUrl = usrDefault.string(forKey: "CurrentBg")!
        guard let imgURL = URL(string: rawUrl) else { return }
        //fetching image and displaying it using KingFisher dependency
        bgImg.kf.setImage(with: imgURL)
        
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
        backBtn.backgroundColor = .clear
        backBtn.layer.borderColor =  UIColor.white.cgColor
        backBtn.layer.borderWidth = 1.5
        backBtn.layer.cornerRadius = 10
        backBtn.setTitle("Back", for: .normal)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        customNavigationBar.addSubview(backBtn)
        
        // Heading of screen
        let titleLabel = UILabel()
        titleLabel.text="Theme Store"
        titleLabel.font = UIFont(name: "System", size: 22)
        titleLabel.textColor = .white
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
        
        if segue.identifier == K.AllThemesSegue {
            let destVC = segue.destination as! SeeAllThemesVC
            destVC.titleText = sectionTitles[currentSection]
            destVC.imgIndex = currentSection
            
        }
        else if segue.identifier == K.tappedThemeSegue {
            let destVC = segue.destination as! SelectedThemeVC
            destVC.selectedWallpaper = tappedWallpaper
            print(tappedWallpaper)
        }
        
    }
    
    func didSelectItemIndex(index: IndexPath) {
        tappedWallpaper = index.item
        performSegue(withIdentifier: K.tappedThemeSegue, sender: self)
    }
    
    
    @objc func seeAllTapped(sender: UIButton)  {
        currentSection = sender.tag
//        debugPrint("\(sectionTitles[currentSection]) see all tapped!")
        performSegue(withIdentifier: K.AllThemesSegue, sender: self)
    }
    
    @objc func backBtnTapped(sender: UIButton)  {
        navigationController?.popViewController(animated: true)
    }
    
    
}


//  MARK: - Table View code & Methods
extension ThemeStoreVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.tableCellIdentifier, for: indexPath) as! TableCell
        cell.delegate = self
        cell.homeCollection.tag = indexPath.section
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 8
    }

    //      Custom Header view with button
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
        headerView.backgroundColor = .clear
        
        let title = UILabel()
        title.text = "\(sectionTitles[section]) Themes"
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let seeAllBtn = UIButton()
        seeAllBtn.translatesAutoresizingMaskIntoConstraints = false
        seeAllBtn.setTitle("See All", for: .normal)
        seeAllBtn.backgroundColor = .clear
        seeAllBtn.addTarget(self, action: #selector(seeAllTapped(sender:)), for: .touchUpInside)
        seeAllBtn.tag = section
        headerView.addSubview(title)
        headerView.addSubview(seeAllBtn)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 12),
            title.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),

            seeAllBtn.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -12),
            seeAllBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5),
            seeAllBtn.heightAnchor.constraint(equalToConstant: 20)

        ])
        
        headerView.addSubview(title)
        headerView.addSubview(seeAllBtn)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .clear
    }
    
    
}

