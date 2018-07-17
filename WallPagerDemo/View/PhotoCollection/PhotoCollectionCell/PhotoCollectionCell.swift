//
//  PhotoCollectionCell.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {

    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateImage(img: UIImage?) {
        if img != nil {
//            print("doi tuong img: \(self.imageView)")
            self.imageView.image = img!
            self.indicatorActivity.stopAnimating()
            self.indicatorActivity.hidesWhenStopped = true
        }
        else {
            self.imageView.image = UIImage.init(named: "not image")
            // thêm điều kiện để kiểm tra indicator đang dừng thì cho chạy còn đang chay thì ko làm gì
            if !self.indicatorActivity.isAnimating {
                self.indicatorActivity.hidesWhenStopped = true
                self.indicatorActivity.startAnimating()
            }
        }
    }

}
