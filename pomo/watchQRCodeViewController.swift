//
//  watchQRCodeViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/12/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit

class watchQRCodeViewController: UIViewController {

    override func viewDidLoad() {
        let alert = UIAlertController(title: "QRCode", message: "is waiting for API", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
