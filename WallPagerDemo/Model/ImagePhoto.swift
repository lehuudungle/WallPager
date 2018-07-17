//
//  ImagePhoto.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper


typealias  Photos = [ImagePhoto]
class ImagePhoto: Mappable {
    var url: String?
    var thumb_url: String?
    var id: Int?
    var likes: Int?
    var urlImage: UIImage?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        url    <- map["url"]
        thumb_url      <- map["thumb_url"]
        id       <- map["id"]
        likes  <- map["likes"]
    }
}

class ImageTags: Mappable {
    var name: String!
    var icon:String!
    var icon_urlImage: UIImage?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        name    <- map["name"]
        icon      <- map["icon"]
    }
}

class Recommended: NSObject, Mappable {
    var name: String!
    var icon: String!
    var icon_urlImage: UIImage?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        name    <- map["name"]
        icon      <- map["icon"]
    }
}

class Categories: NSObject, Mappable {
    var count: Int!
    var show_name:String!
    var name: String!
    var icon:String!
    var iconImage: UIImage!
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        count    <- map["count"]
        show_name      <- map["show_name"]
        name      <- map["name"]
        icon      <- map["icon"]
    }
}

class ImageTypes: NSObject {
    
    override init() {
        super.init()
    }
    var recommended: [Recommended]?
    var categories: [Categories]?
    
}

class ResponseCategorys: Mappable {
    var data: [AnyObject]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        data      <- map["data"]
    }
}
