//
//  KidWatchProfileViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/8/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit

class KidWatchProfileViewController: UIViewController {

    @IBAction func submitButton(_ sender: UIButton) {
        let vc:MasterNavigationController = self.storyboard?.instantiateViewController(withIdentifier: "MasterNavigationController") as! MasterNavigationController
        self.present(vc, animated: true, completion: nil)
        print("eiei")
    }
}

