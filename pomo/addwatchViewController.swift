//
//  addwatchViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/8/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit

class addwatchViewController: UIViewController {

    @IBAction func Skip(sender: UIButton) {
        let vc:MasterNavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("MasterNavigationController") as! MasterNavigationController
        self.presentViewController(vc, animated: true, completion: nil)
        print("eiei")
    }
}
