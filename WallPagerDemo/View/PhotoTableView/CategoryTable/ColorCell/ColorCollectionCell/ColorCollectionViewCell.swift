//
//  ColorCollectionViewCell.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var colorLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(color: String?, text: String?) {
        self.colorLabel.backgroundColor = UIColor.hexStringToUIColor(hex: color!)
        self.colorLabel.text = text!
        self.colorLabel.layer.cornerRadius = 20
        self.colorLabel.layer.masksToBounds = true
    }
}
