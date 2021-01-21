//
//  Alert.swift
//
//  Created by Carlos Rosales on 10/12/15.
//  Copyright © 2015 Carlos Rosales. All rights reserved.
//

import UIKit

class Alert: NSObject {
    
    class func Warning(delegate: UIViewController, message: String) {
        let alert = UIAlertController(title: "FOCUS!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        delegate.present(alert, animated: true, completion: nil)
    }
}
