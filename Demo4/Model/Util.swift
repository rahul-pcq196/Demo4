//
//  Util.swift
//  Demo4
//
//  Created by PCQ196 on 09/02/21.
//

import Foundation
import  UIKit

class Util: NSObject {
    
    private override init() {}

    // shared instance of Util.
    static let sharedInstance: Util = Util()

    // to get particular storyboard name.
    class func getStoryboard() -> UIStoryboard {
        return UIStoryboard(name: K.mainStoryboardName, bundle: nil)
    }
    
    // to check string is null or not.
    class func isStringNull(srcString: String) -> Bool {
        
        if srcString != "" && srcString !=  "null" && !(srcString == "<null>") && !(srcString == "(null)") && (srcString.count) > 0{
            return false
        }
        return true
    }
   
    // to print log in to console.
    class func printLog( _ details : Any = "", _ title : String = "") {
        print("\(title) : \(details)")
    }
}
