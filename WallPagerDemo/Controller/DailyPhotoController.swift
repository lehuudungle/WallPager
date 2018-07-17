//
//  DailyPhotoController.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class DailyPhotoController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        let dailyCollection = PhotoListCollectionView.init(collectionViewLayout: layout)
        addChildViewController(dailyCollection)
        
        let heightNav = (self.navigationController?.navigationBar.frame.height)! + 20
        let heightBar = self.tabBarController?.tabBar.frame.height
        dailyCollection.view.frame = CGRect(x: 0, y: heightNav, width: self.view.frame.width, height: self.view.frame.height - heightNav - heightBar!)
        view.addSubview(dailyCollection.view)
        dailyCollection.didMove(toParentViewController: self)
        
        dailyCollection.didSelectedItem = {browser in
            self.navigationController?.pushViewController(browser!, animated: true)
        }
    }


}
