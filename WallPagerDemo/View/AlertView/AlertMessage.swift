//
//  AlertMessage.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import UIKit

class AlertMessage {
//    static
    class func errorMessage(title: String, messager: String, okAction: String,viewAlert: UIViewController, completion: @escaping () -> ()) {
        let alertController = UIAlertController(title: title, message: messager, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: okAction, style: .default) { (_) in
            completion()
        }
        alertController.addAction(alertAction)
        viewAlert.present(alertController, animated: true, completion: nil)
    }
}
