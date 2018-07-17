//
//  RecommendedCategoryTableCell.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
private let recommendedCollectionResueIndentifier = "RecommendedCategorysCollectionCell"
class RecommendedCategoryTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var listRecommended: [Recommended]?
    var didSelectedRecommenedCollectionViewCell: ((_ nameText: String?) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self 
        self.collectionView.register(UINib.init(nibName: "RecommendedCategorysCollectionCell", bundle: nil), forCellWithReuseIdentifier: recommendedCollectionResueIndentifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(recommendeds: [Recommended]?) {
        self.listRecommended = recommendeds
        self.collectionView.reloadData()
    }
    
}

extension RecommendedCategoryTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if listRecommended != nil {
            return listRecommended!.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendedCollectionResueIndentifier, for: indexPath) as! RecommendedCategorysCollectionCell
        cell.updateCell(img: listRecommended![indexPath.row].icon_urlImage, title: listRecommended![indexPath.row].name)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if didSelectedRecommenedCollectionViewCell != nil {
            didSelectedRecommenedCollectionViewCell!(self.listRecommended![indexPath.row].name)
        }
    }
}
