//
//  DownloadImage.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import AlamofireObjectMapper
import Alamofire
import Reachability
import ObjectMapper

class DownloadImage {
    static let shared = DownloadImage()
    func getDataPhoto(urlString: String, completion: @escaping (_ listPhoto: [ImagePhoto]?, _ error: ServerError?) -> Void) {
        guard let urlImage = URL.init(string: urlString) else {
            return
        }
        let reachability = Reachability()
        reachability?.whenReachable = {reachability in
            Alamofire.request(urlImage).responseArray(keyPath: "images") { (response: DataResponse<Photos>) in
                switch response.result {
                case .success:
                    completion(response.result.value,nil)
                case .failure(_):
                    completion(nil,ServerError.systemError(response.result.error!))
                }
            }
        }
        reachability?.whenUnreachable = {reachability in
            completion(nil, ServerError.customerError(ServerErrorMessage.noConnectNetwork.rawValue))
        }
        try! reachability?.startNotifier()
    }
    
    func getTitleDataImage(urlString: String, completion: @escaping (_ imgTags: [ImageTags]?, _ error: ServerError?) -> Void) {
        guard let urlImage = URL.init(string: urlString) else {
            return
        }
        let reachability = Reachability()
        reachability?.whenReachable = {reachability in
            Alamofire.request(urlImage).responseArray(keyPath: "tags") { (response: DataResponse<[ImageTags]>) in
                switch response.result {
                case .success:
                    completion(response.result.value,nil)
                case .failure(_):
                    completion(nil,ServerError.systemError(response.result.error!))
                }
            }
        }
        reachability?.whenUnreachable = {reachability in
            completion(nil, ServerError.customerError(ServerErrorMessage.noConnectNetwork.rawValue))
        }
        try! reachability?.startNotifier()
    }
    
    func getCategoriesRecommended(urlString: String?, completion: @escaping (_ imgTypes: ImageTypes?, _ error: ServerError?) -> Void) {
        guard let urlImage = URL.init(string: urlString!) else {
            return
        }
        let reachability = Reachability()
        reachability?.whenReachable = {reachability in
            Alamofire.request(urlImage).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    let json = response.result.value as? NSDictionary
                    let data = json!["data"] as? NSArray
                    // convert recommended
                    let recommendedDict = data![0] as? NSDictionary
                    let recommendedArray = recommendedDict!["recommended"] as? NSArray
                    
                    var reList = [Recommended]()
                    for item in recommendedArray! {
                        let itemRecommended = Recommended()
                        itemRecommended.mapping(map: Map.init(mappingType: .fromJSON, JSON: item as! [String: Any]))
                        print("re url: \(itemRecommended.icon)")
                        reList.append(itemRecommended)
                    }
                    
                    // convert categorys
                    
                    let categoriesDict = data![1] as? NSDictionary
                    let categoriesArray = categoriesDict!["categories"] as? NSArray
                    var categoryList = [Categories]()
                    
                    for item in categoriesArray! {
                        let itemCategories = Categories()
                        itemCategories.mapping(map: Map.init(mappingType: .fromJSON, JSON: item as! [String: Any]))
                        categoryList.append(itemCategories)
                    }
                    
                    // convet ImageTypes
                    let imgTypes = ImageTypes()
                    imgTypes.categories = categoryList
                    imgTypes.recommended = reList
                    completion(imgTypes,nil)
                case .failure(_):
                    completion(nil,ServerError.systemError(response.result.error!))
                }
            })
        }
        reachability?.whenUnreachable = {reachability in
            completion(nil, ServerError.customerError(ServerErrorMessage.noConnectNetwork.rawValue))
        }
        try! reachability?.startNotifier()
    }
}
