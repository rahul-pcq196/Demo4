//
//  Define.swift
//  Demo3
//
//  Created by PCQ196 on 04/02/21.
//

import Foundation
import UIKit

// to get screen height and width.
let screenHeight = UIScreen.main.bounds.size.height
let screenWidth =  UIScreen.main.bounds.size.width

// to set localizable string into project.
public func localize(str: String) -> String{
    return NSLocalizedString(str, comment: "")
}
