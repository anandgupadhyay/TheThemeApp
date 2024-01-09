//
//  SelectedCell.swift
//  Theme-App
//
//  Created by Anand Upadhyay on 07/01/24.
//

import UIKit

class SelectedCell: UICollectionViewCell {
    var wallpaperImg: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        wallpaperImg = UIImageView(frame: contentView.bounds)
        wallpaperImg.contentMode = .scaleAspectFill
        wallpaperImg.translatesAutoresizingMaskIntoConstraints = false
        wallpaperImg.layer.cornerRadius = 25
        wallpaperImg.layer.masksToBounds = true
        contentView.addSubview(wallpaperImg)
        
        NSLayoutConstraint.activate([
            wallpaperImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            wallpaperImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            wallpaperImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            wallpaperImg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
