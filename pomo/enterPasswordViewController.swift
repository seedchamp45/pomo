//
//  enterPasswordViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/8/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit

class enterPasswordViewController: UIViewController {
    
    @IBAction func Next(_ sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "User Agreement", message: "Do you read and agree that User Agregment", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        // add the actions (buttons)
        let OKAction = UIAlertAction(title: "OK", style: .default){
            (action) in
            let vc: addwatchViewController = self.storyboard?.instantiateViewController(withIdentifier: "addwatchViewController") as! addwatchViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alert.addAction(OKAction)
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    

    

}
