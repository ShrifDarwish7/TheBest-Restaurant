//
//  ChooseCollectionViewCell.swift
//  TheBest-iOS-Driver
//
//  Created by Sherif Darwish on 10/4/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit

class ChooseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var check: UIImageView!
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var categoryImage: UIImageView!
    
    func loadFrom(option: Option){
        title.text = option.title
        check.image = option.selected == true ? UIImage(named: "checked") : UIImage(named: "unchecked")
    }
    
    func loadFrom(category: MainCategory){
        title.text = category.name
        check.image = category.selected == true ? UIImage(named: "checked") : UIImage(named: "unchecked")
        imageContainer.isHidden = false
        imageContainer.layer.cornerRadius = imageContainer.frame.height/2
        categoryImage.layer.cornerRadius = categoryImage.frame.height/2
        categoryImage.sd_setImage(with: URL(string: category.hasImage ?? ""))
    }
    
    func loadFrom(additionalItem: AdditionalItem){
        title.text = additionalItem.nameEn
        check.image = additionalItem.selected == true ? UIImage(named: "checked") : UIImage(named: "unchecked")
        imageContainer.isHidden = true
    }
    
}
