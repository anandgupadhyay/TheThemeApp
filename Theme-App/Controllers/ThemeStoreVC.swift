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
    @IBOutlet weak var btnMyThemes: UIButton!
    
    var sectionTitles = ["Best Selling", "New Year", "Movies", "Traditional", "Trending", "Graphic", "Premium", "Free"]
    var currentSection = 0
    var tappedWallpaper = 0
    var isLoading = true
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBgFromUsrDefault()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMyThemes.isHidden = true
        navigationController?.navigationBar.isHidden = true
        customNavBar()
        
        if #available(iOS 15.0, *) {
            homeTable.sectionHeaderTopPadding = 20
        } else {
            // Fallback on earlier versions
        }
        self.view.isUserInteractionEnabled = false
        stopShimerAfterSomeTime()
    }
    
    func stopShimerAfterSomeTime(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) { [weak self] in
            self?.isLoading = false
            self?.view.isUserInteractionEnabled = true
            self?.homeTable.reloadData()
            self?.btnMyThemes.isHidden = false
        }
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
        
        backBtn.setBackButtonCornerAndBorder()
        backBtn.setTitle("BACK", for: .normal)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.addTarget(self, action: #selector(backBtnTapped(sender:)), for: .touchUpInside)
        customNavigationBar.addSubview(backBtn)
        
        // Heading of screen
        let titleLabel = UILabel()
        titleLabel.text="Theme Store"
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
        cell.reloadImages()
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
//        let headerViewOld = tableView.viewWithTag(121)
//        if headerViewOld != nil {
//            headerViewOld?.removeFromSuperview()
//        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
        headerView.tag = 121
        headerView.backgroundColor = .clear
        
        let title = MyLabel()
        title.text = "\(sectionTitles[section]) Themes"
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        
        let seeAllBtn = MyButton()
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
            seeAllBtn.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
            seeAllBtn.heightAnchor.constraint(equalToConstant: 20),
            seeAllBtn.widthAnchor.constraint(equalToConstant: 60),
        ])
        
        headerView.addSubview(title)
        headerView.addSubview(seeAllBtn)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = .clear
        tableView.setTemplateWithSubviews(isLoading, viewBackgroundColor: .gray)
    }
}

