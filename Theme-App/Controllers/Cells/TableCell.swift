//
//  TableCell.swift
//  Theme-App
//
//  Created by Anand Upadhyay on 03/01/24.
//

import UIKit

class TableCell: UITableViewCell{
    @IBOutlet weak var homeCollection: UICollectionView!
    
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
}

extension TableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.collectionCellIdentifier, for: indexPath) as! CollectionCell
        cell.wallpaperImg.image = UIImage(named: "bg\(homeCollection.tag + 1)")
//        cell.wallpaperImg.image
        cell.wallpaperImg.layer.cornerRadius = 25
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
