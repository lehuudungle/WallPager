//
//  HotPhotoController.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class HotPhotoController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        let hotCollection = PhotoListCollectionView.init(collectionViewLayout: layout)
        addChildViewController(hotCollection)
        
        let heightNav = (self.navigationController?.navigationBar.frame.height)! + 20
        let heightBar = self.tabBarController?.tabBar.frame.height
        hotCollection.view.frame = CGRect(x: 0, y: heightNav, width: self.view.frame.width, height: self.view.frame.height - heightNav - heightBar!)
        view.addSubview(hotCollection.view)
        hotCollection.didMove(toParentViewController: self)
        hotCollection.didSelectedItem = {browser in
            self.navigationController?.pushViewController(browser!, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
