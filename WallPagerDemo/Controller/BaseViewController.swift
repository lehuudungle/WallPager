//
//  BaseViewController.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    private var urlPhoto: String?
    private var listImage: [ImagePhoto]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUrlPhoto()
    }
    
    func getUrlPhoto(){
        if(Common.shared.isIphone4()){
            SIZE_LINK = "app=wallhd-10000&device=iPhone4%2C1&devicesize=640x960&ios=9.3.5&thumb=305x543&version=4.6"
            
        }else if(Common.shared.isIphone5()){
            SIZE_LINK = "app=wallhd-10000&device=iPhone5%2C1&devicesize=640x1136&ios=10.0.1&thumb=305x543&version=4.6"
            
        }else {
            print("day la iphone 7")
            SIZE_LINK = "app=wallhd-10000&device=iPhone7%2C2&devicesize=750x1334&ios=10.0.1&thumb=305x543&version=4.6"
            
        }
        let indexSelect = self.tabBarController?.selectedIndex
        
        switch indexSelect! {
        case 0:
            URL_PHOTO = DAILY_URL
            break
        case 1:
            URL_PHOTO = HOT_URL
            
            break
        case 2:
            URL_PHOTO = FEATURE_URL
            print("bang 2")
            break
        case 3:
            URL_PHOTO = LIST_CATEGORY_URL
        default:
            print("default")
            break
        }
        
    }

}
