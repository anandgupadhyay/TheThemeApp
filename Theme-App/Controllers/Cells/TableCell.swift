//
//  TableCell.swift
//  Theme-App
//
//  Created by Anand Upadhyay on 08/01/24.
//

import UIKit
import Kingfisher

protocol selectedWallpaperDelegate {
    func didSelectItemIndex(index: IndexPath)
}

class TableCell: UITableViewCell{
    
    @IBOutlet weak var homeCollection: UICollectionView!
    
    var currentIndex = 0
    var currentSection = 0
    var isLoading = true
    var delegate: selectedWallpaperDelegate?

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        homeCollection.dataSource = self
        homeCollection.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func reloadImages(){
        homeCollection.reloadData()
        
//        stopShimerAfterSomeTime()
    }
    
//    func stopShimerAfterSomeTime(){
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) { [weak self] in
//            self?.isLoading = false
//            self?.homeCollection.reloadData()
//        }
//    }
}


extension TableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.collectionCellIdentifier, for: indexPath) as! CollectionCell
        
        currentIndex = indexPath.item
        currentSection = homeCollection.tag
        
        cell.wallpaperImg.image = UIImage(named: "placeholder")
        cell.wallpaperImg.kf.indicatorType = .activity
        cell.wallpaperImg.layer.cornerRadius = 25
        
        //  kingfisher code
//        let cache = ImageCache.default
//        cache.memoryStorage.config.expiration = .seconds(600/2)
//        let cached = cache.isCached(forKey: "img\(currentSection)\(currentIndex)")
//        let cached = cache.isCached(forKey: "img\(currentSection)")
//        if(cached) {
            
//            cache.retrieveImageInDiskCache(forKey: "img\(currentSection)") { result in
//                switch result {
//                    //  IF IMAGE IS PRESENT IN CACHE
//                case .success(let value):
//                    print("cashed")
//                    DispatchQueue.main.async {
//                        cell.wallpaperImg.image = value
//                    }
//                    //  IF error occured
//                case .failure(let error):
//                    print("failed to retrice image form cache\(error)")
//                    
//                }
//            }
//            //  IF IMAGE IS NOT PRESENT IN CACHE
//        } else {
            cell.wallpaperImg.kf.indicatorType = .activity
            let resource = KF.ImageResource(downloadURL: URL(string: imgUrlArr[homeCollection.tag])!, cacheKey: imgUrlArr[homeCollection.tag])
            cell.wallpaperImg.kf.setImage(with: resource)//, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(0.2))])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItemIndex(index: indexPath)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
 
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        cell.setTemplateWithSubviews(isLoading, viewBackgroundColor: .systemBackground)
    }
    
//    func CacheImg() {
//        let ImgRec = ImageResource(downloadURL: imgUrlArr[currentSection], cacheKey: "img\(currentSection)\(currentIndex)")
//        cell.wallpaperImg.kf.setImage(with: )
//    }
}
