//
//  ColorCategoryTableViewCell.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
private let colorCollectionResueIndentifier = "ColorCollectionViewCell"
class ColorCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var colorList: [String]?
    var textList: [String]?
    var didSelectedCollectionCell: ((_ colorText: String?) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "ColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: colorCollectionResueIndentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(colors: [String]?, texts: [String]?) {
        colorList = colors
        textList = texts
    }
}

extension ColorCategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if textList != nil {
            return textList!.count
        }
        return 0
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 100, height: 100)
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colorCollectionResueIndentifier, for: indexPath) as! ColorCollectionViewCell
        cell.updateCell(color: colorList?[indexPath.row], text: textList?[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if didSelectedCollectionCell != nil {
            didSelectedCollectionCell!(self.colorList![indexPath.row])
        }
//        let layout = UICollectionViewFlowLayout()
//        URL_PHOTO = COLOR_URL + colorList![indexPath.row] + "/%d?%@"
//        var detail = PhotoListCollectionView(collectionViewLayout: layout)
//        detail.delegateController = delegateCategory
//        delegateCategory.navigationController?.pushViewController(detail, animated: true)
    }
    
}
