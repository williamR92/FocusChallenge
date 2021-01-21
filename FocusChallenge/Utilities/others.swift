//
//  others.swift
//  FocusChallenge
//
//  Created by Carlos Rosales on 1/20/21.
//

import Foundation
import Foundation
import UIKit

extension UITextField {
    func setBottomBorder() {
        //self.borderStyle = .none
        self.layer.backgroundColor = UIColor.black.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = (UIColor.white).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.4)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
