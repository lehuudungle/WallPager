//
//  Common.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit
let DAILY_URL = "http://d2-wallpaperv3.ticktockapps.com/res/image/all/%d?%@"
let HOT_URL = "http://d2-wallpaperv3.ticktockapps.com/res/image/popular/%i?%@"
let FEATURE_URL = "http://d2-wallpaperv3.ticktockapps.com/res/tag/appfeature?%@"
let DETAIL_FEATURE_URL = "http://d2-wallpaperv3.ticktockapps.com/res/image/search/"
let LIST_CATEGORY_URL = "http://d2-wallpaperv3.ticktockapps.com/res/tag/category.json?%@"
let COLOR_URL = "http://d2-wallpaperv3.ticktockapps.com/res/image/color/"
let RECOMMED_URL = "http://d2-wallpaperv3.ticktockapps.com/res/image/tag/"
let SEARCH_URL = "http://d2-wallpaperv3.ticktockapps.com/res/image/search/"
var URL_PHOTO:String!
var SIZE_LINK:String!
var rel: UICollectionView!

class Common{
    static let shared = Common()
    func isIphone5()->Bool{
        return UIScreen.main.bounds.height == 568
    }
    func isIphone4()->Bool{
        return UIScreen.main.bounds.height == 480
    }
    func isIphone7()->Bool{
        return UIScreen.main.bounds.height == 667
    }
    
}

extension UIColor {
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
