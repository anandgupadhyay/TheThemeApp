//
//  SelectedThemeViewController.swift
//  Theme-App
//
//  Created by Anand Upadhyay on 03/01/24.
//

import UIKit
import Kingfisher

class SelectedThemeVC: UIViewController {

    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var descpLabel: UILabel!
    @IBOutlet weak var applyThemeBtn: UIButton!
    var collection:UICollectionView!
    
    var selectedWallpaper = 0
    
    var imgUrlArr = [
        K.imgUrl1,
        K.imgUrl2,
        K.imgUrl3,
        K.imgUrl4,
        K.imgUrl5,
        K.imgUrl6,
        K.imgUrl7,
        K.imgUrl8,
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

        setBgImg()
        let firstIndexPath = IndexPath(item: 1, section: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.collection.scrollToItem(at: firstIndexPath, at: .centeredHorizontally, animated: true)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        customNavBar()
        setupCollectionView()
//        applyThemeBtn.layer.cornerRadius = 30
        setDescp()
        navigationItem.title = "Theme"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    
    
    func setBgImg() {
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
    
    
    func setDescp() {
        descpLabel.text = K.wallpaperDescp
        descpLabel.textAlignment = .left
        
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width / 2, height: 300)
        layout.scrollDirection = .horizontal

        collection = UICollectionView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 350), collectionViewLayout: layout)

        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        //  Register cell classes
        collection.register(SelectedCell.self, forCellWithReuseIdentifier: "SelectedCell")

        //  Add collectionView to the view hierarchy
        view.addSubview(collection)
        
        //  scaling first cell
//        let firstIndexPath = IndexPath(item: 0, section: 0)
//        let firstCell = collection.cellForItem(at: firstIndexPath)
//        firstCell?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
    }
    
    
    @IBAction func applyThemeTapped(_ sender: UIButton) {
        //to set the background image url 9 Jan 2024
//        UserDefaults.standard.set(backgroundURL, forKey:UserDefaultKeys.appBackgorundImageUrl.rawValue)
//        NotificationCenter.default.post(name: Notification.Name("BackgroundImageFetch"), object: nil)
    }
    
    
    @objc func backBtnTapped(sender: UIButton)  {
        navigationController?.popViewController(animated: true)
    }
    
    
}


extension SelectedThemeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    //      Datasource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedCell", for: indexPath) as! SelectedCell
        cell.wallpaperImg.kf.indicatorType = .activity
        cell.wallpaperImg.kf.setImage(with: URL(string: imgUrlArr[selectedWallpaper]), placeholder: UIImage(named: "placeholder"))
        cell.wallpaperImg.layer.cornerRadius = 25
        cell.wallpaperImg.contentMode = .scaleAspectFill
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        return cell
    }
    
    //      FlowLayot methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerX = scrollView.contentOffset.x + scrollView.frame.width / 2
        for cell in collection.visibleCells {
            let distance = abs(centerX - cell.center.x)
            let scale = max(1 - distance / scrollView.frame.width, 0.5)
            cell.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        let collectionViewWidth = collectionView.bounds.size.width
        let targetX = proposedContentOffset.x + collectionViewWidth / 2
        let targetIndexPath = collectionView.indexPathForItem(at: CGPoint(x: targetX, y: collectionView.bounds.size.height / 2)) ?? IndexPath(item: 0, section: 0)
        let targetCellAttributes = collectionView.layoutAttributesForItem(at: targetIndexPath)
        let targetOffsetX = targetCellAttributes?.center.x ?? 0 - collectionViewWidth / 2
        
        return CGPoint(x: targetOffsetX, y: proposedContentOffset.y)
    }

}
