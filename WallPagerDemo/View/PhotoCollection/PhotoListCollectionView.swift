//
//  PhotoListCollectionView.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SVPullToRefresh
import MBProgressHUD
import MWPhotoBrowser

private let reuseIdentifier = "PhotoCollectionCell"
class PhotoListCollectionView: UICollectionViewController {
    
    private var listImage = [ImagePhoto]()
    private var currentPage = 1
    var didSelectedItem: ((_ browser: MWPhotoBrowser?) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.register(UINib(nibName: "PhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
        loadUI()
        self.collectionView?.addPullToRefresh(actionHandler: {
            self.listImage.removeAll()
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
            self.currentPage = 1
            self.loadUI()
        })
        
        self.collectionView?.addInfiniteScrolling(actionHandler: {
            self.currentPage  = self.currentPage + 1
            self.loadUI()
        })
    }
    
    func loadUI() {
        var urlFormat = String(format: URL_PHOTO!, currentPage,SIZE_LINK)
        urlFormat = urlFormat.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        DownloadImage.shared.getDataPhoto(urlString: urlFormat) { (listPhoto, error) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if error != nil {
                
                AlertMessage.errorMessage(title: "Error", messager: (error?.detail.messageError)!, okAction: "OK", viewAlert: self, completion: {
                    
                })
                
            } else {
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    if let pullData = self.collectionView?.pullToRefreshView {
                        pullData.stopAnimating()
                    }
                    if let infinite = self.collectionView?.infiniteScrollingView {
                        infinite.stopAnimating()
                    }
                    self.listImage.append(contentsOf: listPhoto!)
                    for img in self.listImage {
                        let imageData = try! Data.init(contentsOf: URL.init(string: img.url!)!)
                        DispatchQueue.main.async {
                            img.urlImage = UIImage(data: imageData)
                            self.collectionView?.reloadData()
                        }
                        
                    }
                }
            }
        }
        
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if listImage.count != 0 {
            return listImage.count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        // Configure the cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionCell
//        print("so phan tu: \(self.listImage.count)")
        cell.updateImage(img: listImage[indexPath.row].urlImage)
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let browser = MWPhotoBrowser(delegate: self)
        browser?.displayActionButton = true
        browser?.zoomPhotosToFill = true
        browser?.enableSwipeToDismiss = true
        browser?.setCurrentPhotoIndex(UInt(indexPath.row))
        if didSelectedItem != nil {
            didSelectedItem!(browser)
        }
    }
   
}

// MARK: MWPhotoDelegate

extension PhotoListCollectionView:MWPhotoBrowserDelegate{
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return UInt(listImage.count)
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        
        if(Int(index) < self.listImage.count){
            return MWPhoto(image: self.listImage[Int(index)].urlImage)
        }
        return nil
    }
    
    
}

//MARK: UICOLLECTIONVIEW DELEGATE FLOW LAYOUT
extension PhotoListCollectionView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
        let paddingSpace = sectionInsets.left * (3 + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 3
        
        return CGSize(width: widthPerItem, height: widthPerItem)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0).left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
    
}
