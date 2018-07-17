//
//  RecommendedCategorysCollectionCell.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class RecommendedCategorysCollectionCell: UICollectionViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(img: UIImage?, title: String?) {
        self.iconImage.image = img
        self.titleLabel.text = title!
    }

}
