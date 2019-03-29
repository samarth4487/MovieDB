//
//  AlertView.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 28/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import Foundation
import UIKit

class AlertView: NSObject {
    
    static func showAlert(inVC vc: UIViewController, withMessage message: String) {
        /*
         This method shows an alert in the view controller from where it was called
        */
        
        let alert = UIAlertController(title: "Uh-oh!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
