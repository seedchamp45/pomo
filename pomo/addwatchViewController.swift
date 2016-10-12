//
//  addwatchViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/8/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit

class addwatchViewController: UIViewController {

    @IBAction func Skip(_ sender: UIButton) {
        let vc:MasterNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "MasterNavigationController") as! MasterNavigationController
        self.present(vc, animated: true, completion: nil)
        print("eiei")
    }
}
