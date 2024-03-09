//
//  CollectionCell.swift
//  Theme-App
//
//  Created by Anand Upadhyay on 07/01/24.
//

import UIKit


class CollectionCell: UICollectionViewCell, ShimmeringViewProtocol {
    
    @IBOutlet weak var wallpaperImg: UIImageView!
    
    var shimmeringAnimatedItems: [UIView] {
        [
            wallpaperImg
        ]
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        wallpaperImg.image = nil
        wallpaperImg.image = UIImage(named: "placeholder")
    }
    
}

