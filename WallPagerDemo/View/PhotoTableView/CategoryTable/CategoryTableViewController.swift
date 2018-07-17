//
//  CategoryTableViewController.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/17/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
private let colorResueIndentifier = "ColorCategoryTableViewCell"
private let recommendedIndentifier = "RecommendedCategoryTableCell"
class CategoryTableViewController: UITableViewController {
        
    @IBOutlet var categoryTable: UITableView!
    var listColor = ["ff93a3","fefd31","a62afa","343434","0669e8","bcbcbc","eb392b","ffffff"]
    var listText = ["Pink","Yellow","Purple","Back","Blue","Grey","Red","White"]
    var listRecomment = [Recommended]()
    var listCategories = [Categories]()
    var didSeletedColorCell: ((_ colorText: String) -> ())?
    var didSelectedRecommendedCell: ((_ nameText: String) -> ())?
    var didSelectedCategoryCell: ((_ nameText: String) -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.categoryTable.register(UINib(nibName: "ColorCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: colorResueIndentifier)
        self.categoryTable.register(UINib(nibName: "RecommendedCategoryTableCell", bundle: nil), forCellReuseIdentifier: recommendedIndentifier)
        loadUI()
    }
    

    func loadUI() {
        let stringFromat = String(format: URL_PHOTO, SIZE_LINK)
        DownloadImage.shared.getCategoriesRecommended(urlString: stringFromat) { (imgTypes, error) in
            if error != nil {
                AlertMessage.errorMessage(title: "Error", messager: (error?.detail.messageError)!, okAction: "OK", viewAlert: self, completion: {
                    
                })
            } else {
                print("so phan tu:\(imgTypes?.recommended?.count)")
                if let recommendeds = imgTypes?.recommended {
                    self.listRecomment.removeAll()
                    self.listRecomment.append(contentsOf: recommendeds)
                    print("so phan tu: \(self.listRecomment.count)")
                }
                
                if let categories = imgTypes?.categories {
                    self.listCategories.removeAll()
                    self.listCategories.append(contentsOf: categories)
                }
                
                DispatchQueue.global(qos: .userInitiated).async {
                    for item in self.listRecomment {
                        print("url thu: \(item.icon!)")
                        let imageData = try! Data.init(contentsOf: URL.init(string: item.icon!)!)
                        DispatchQueue.main.async {
                            item.icon_urlImage = UIImage(data: imageData)
                            print("url: \(item.icon_urlImage)")
                            self.categoryTable.reloadData()
                        }
                    }
                    for item in self.listCategories {
                        let imageData = try! Data.init(contentsOf: URL.init(string: item.icon)!)
                        DispatchQueue.main.async {
                            item.iconImage = UIImage(data: imageData)
                            self.categoryTable.reloadData()
                        }
                    }
                }
            }
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Color"
        case 1:
            return "Recommended"
        default:
            return "Categories"
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 60
        }
        return 150
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0,1:
            return 1
        default:
            return self.listCategories.count
            
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: colorResueIndentifier) as! ColorCategoryTableViewCell
            cell.updateCell(colors: self.listColor, texts: self.listText)
            cell.didSelectedCollectionCell = {colorText in
                if self.didSeletedColorCell != nil {
                    self.didSeletedColorCell!(colorText!)
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: recommendedIndentifier) as! RecommendedCategoryTableCell
            cell.updateCell(recommendeds: self.listRecomment)
            cell.didSelectedRecommenedCollectionViewCell = {nameText in
                if self.didSelectedRecommendedCell != nil {
                    self.didSelectedRecommendedCell!(nameText!)
                }
            }
            return cell 
        default:
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
                cell?.textLabel?.text = self.listCategories[indexPath.row].name
            }
            return cell!
        }
        return UITableViewCell.init(style: .default, reuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if didSelectedCategoryCell != nil {
                didSelectedCategoryCell!(self.listCategories[indexPath.row].name)
            }
        }
    }
}
