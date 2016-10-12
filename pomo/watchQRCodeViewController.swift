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
        let alert = UIAlertController(title: "QRCode", message: "is waiting for API", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
