//
//  MainTabBarController.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = true 
        let dailyController = DailyPhotoController()
        let hotController = HotPhotoController()
        let featureController = FeaturePhotoController()
        let categoryController = CategoryPhotoController()
        
        let dailyRootController = BaseNavigationController(rootViewController: dailyController)
        let hotRootController = BaseNavigationController(rootViewController: hotController)
        let featureRootController = BaseNavigationController(rootViewController: featureController)
        let categoryRootController = BaseNavigationController(rootViewController: categoryController)
        
//        dailyRootController.isNavigationBarHidden = true
//        hotRootController.isNavigationBarHidden = true
        
        setupForEachRootController(viewcontroller: dailyController, navTitle: "Dailly", tabbarTitle: "Daily", image: "daily", selectedImage: "selectedDaily")
        setupForEachRootController(viewcontroller: hotController, navTitle: "HotDay", tabbarTitle: "HotDay", image: "hotDay", selectedImage: "selectedHotDay")
        setupForEachRootController(viewcontroller: featureController, navTitle: "Feature", tabbarTitle: "Feature", image: "hotDay", selectedImage: "selectedHotDay")
        setupForEachRootController(viewcontroller: categoryController, navTitle: "Category", tabbarTitle: "Category", image: "hotDay", selectedImage: "selectedHotDay")
        
        self.viewControllers = [dailyRootController, hotRootController,featureRootController,categoryRootController]
    }
    
    func setupForEachRootController(viewcontroller: BaseViewController,
                                    navTitle: String, tabbarTitle: String,
                                    image: String,
                                    selectedImage: String) {
        viewcontroller.navigationItem.title = navTitle
        let unSelectedImage = UIImage(named: image)!.withRenderingMode(.alwaysOriginal)
        let selectedImage =  UIImage(named: selectedImage)!.withRenderingMode(.alwaysOriginal)
        
        viewcontroller.tabBarItem =
            UITabBarItem(title: tabbarTitle, image:unSelectedImage, selectedImage:  selectedImage)
    }

}
