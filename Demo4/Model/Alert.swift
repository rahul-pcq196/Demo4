//
//  Alert.swift
//  Demo3
//
//  Created by PCQ196 on 05/02/21.
//

import Foundation
import UIKit

class Alert : NSObject {

    private override init() { }

    static let shared = Alert()
    
    // to show alert with title and message
    func ShowAlert(title: String, message: String, in vc: UIViewController , withAction : [UIAlertAction]? = nil , addCloseAction : Bool = true) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        if addCloseAction {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
        
        if withAction != nil {
            for ac in withAction! {
                alert.addAction(ac)
            }
        }
        
        if !Util.isStringNull(srcString: title) {
            vc.present(alert, animated: true, completion: nil)
        }
    }
   
}
