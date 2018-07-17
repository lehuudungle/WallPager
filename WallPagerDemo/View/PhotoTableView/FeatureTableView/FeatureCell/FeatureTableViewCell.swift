//
//  FeatureTableViewCell.swift
//  Demo_WallPhoto
//
//  Created by Ledung95d on 7/14/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

    @IBOutlet var titleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("load cell")
    }
    
    static let featureCellIdentifier = "FeatureTableViewCell"
    class func featureCell() -> String {
        return featureCellIdentifier
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCell(img: UIImage?) {
         self.titleImage.image = UIImage(named: "not image")
        if img != nil {
            self.titleImage.image = img!
        }
    }
    
}
