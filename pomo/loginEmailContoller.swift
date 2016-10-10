//
//  loginEmailContoller.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/10/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit

class loginEmailContoller: UIViewController {

    @IBAction func loginButton(sender: UIButton) {
        let vc:MasterNavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("MasterNavigationController") as! MasterNavigationController
        self.presentViewController(vc, animated: true, completion: nil)
        print("eiei")
    }
}
