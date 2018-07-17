//
//  FeaturePhotoController.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SVPullToRefresh
import MBProgressHUD

private let reuseIdentifier = "FeatureTableViewCell"
class FeaturePhotoController: BaseViewController {

    var featureTable: UITableView?
    var imgTags = [ImageTags]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        featureTable = UITableView()
        featureTable?.dataSource = self
        featureTable?.delegate = self
        featureTable?.register(UINib(nibName: "FeatureTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        let heightNav = (self.navigationController?.navigationBar.frame.height)! + 20
        let heightBar = self.tabBarController?.tabBar.frame.height
        featureTable?.frame = CGRect(x: 0, y: heightNav, width: self.view.frame.width, height: self.view.frame.height - heightNav - heightBar!)
        self.view.addSubview(featureTable!)
        
        loadUI()
//        self.featureTable?.addPullToRefresh(actionHandler: {
//            self.listImage.removeAll()
//            DispatchQueue.main.async {
//                self.featureTable?.reloadData()
//            }
//            self.currentPage = 1
//            self.loadUI()
//        })
        
//        self.featureTable?.addInfiniteScrolling(actionHandler: {
//            self.currentPage  = self.currentPage + 1
//            self.loadUI()
//        })
    }
    
    func loadUI() {
        let urlFormat = String(format: URL_PHOTO, SIZE_LINK)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        DownloadImage.shared.getTitleDataImage(urlString: urlFormat) { (imageList,error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if error != nil {
                AlertMessage.errorMessage(title: "Error", messager: (error?.detail.messageError)!, okAction: "OK", viewAlert: self, completion: {
                    
                })
            } else {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.imgTags.append(contentsOf: imageList!)
                    for img in self.imgTags {
                        let imageData = try! Data.init(contentsOf: URL.init(string: img.icon)!)
                        DispatchQueue.main.async {
                            img.icon_urlImage = UIImage(data: imageData)
                            self.featureTable?.reloadData()
                        }
                        
                    }
                }
            }
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

extension FeaturePhotoController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if imgTags.count != 0 {
            return imgTags.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = featureTable?.dequeueReusableCell(withIdentifier: reuseIdentifier) as! FeatureTableViewCell
        cell.updateCell(img: imgTags[indexPath.row].icon_urlImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        URL_PHOTO = DETAIL_FEATURE_URL
        URL_PHOTO = String(format: "%@%@",URL_PHOTO,self.imgTags[indexPath.row].name!)
        URL_PHOTO = URL_PHOTO + String("/%d?%@")
        let layout = UICollectionViewFlowLayout()
        let collectionPhoto = PhotoListCollectionView(collectionViewLayout: layout)
        self.navigationController?.pushViewController(collectionPhoto, animated: true)
        collectionPhoto.didSelectedItem = {browser in
            self.navigationController?.pushViewController(browser!, animated: true)
        }
    }
}
