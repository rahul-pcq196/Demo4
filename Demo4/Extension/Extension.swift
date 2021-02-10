//
//  Extension.swift
//  Demo2
//
//  Created by PCQ196 on 02/02/21.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable
    var borderColor : UIColor {
        get {
            return .white
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable
    var borderWidth : CGFloat {
        get {
            return 0
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var cornerRadius : CGFloat {
        get {
            return 0
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }

}

extension UITextField {
    
    func leftPadding(padding : CGFloat) {

            let vw = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.size.height))
            self.leftView = vw
            self.leftViewMode = .always
    }
}

