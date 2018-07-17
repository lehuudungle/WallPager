//
//  CategoryPhotoController.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class CategoryPhotoController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let categoryTable = CategoryTableViewController()
        addChildViewController(categoryTable)
        let heightNav = (self.navigationController?.navigationBar.frame.height)! + 20
        let heightBar = self.tabBarController?.tabBar.frame.height
        categoryTable.view.frame = CGRect(x: 0, y: heightNav, width: self.view.frame.width, height: self.view.frame.height - heightNav - heightBar!)
        view.addSubview(categoryTable.view)
        categoryTable.didMove(toParentViewController: self)
        categoryTable.didSeletedColorCell = {colorText in
            let layout = UICollectionViewFlowLayout()
            URL_PHOTO = COLOR_URL + colorText + "/%d?%@"
            let detail = PhotoListCollectionView(collectionViewLayout: layout)
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
        categoryTable.didSelectedRecommendedCell = {nameText in
            let layout = UICollectionViewFlowLayout()
            URL_PHOTO = RECOMMED_URL + nameText + "/%d?%@"
            let detail = PhotoListCollectionView(collectionViewLayout: layout)
            self.navigationController?.pushViewController(detail, animated: true)
        }
        
        categoryTable.didSelectedCategoryCell = {nameText in
            let layout = UICollectionViewFlowLayout()
            URL_PHOTO = RECOMMED_URL + nameText + "/%d?%@"
            let detail = PhotoListCollectionView(collectionViewLayout: layout)
            self.navigationController?.pushViewController(detail, animated: true)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
