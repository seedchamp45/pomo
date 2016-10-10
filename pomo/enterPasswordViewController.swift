//
//  enterPasswordViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/8/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit

class enterPasswordViewController: UIViewController {
    
    @IBAction func Next(sender: UIButton) {
        // create the alert
        let alert = UIAlertController(title: "User Agreement", message: "Do you read and agree that User Agregment", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // add the actions (buttons)
        let OKAction = UIAlertAction(title: "OK", style: .Default){
            (action) in
            let vc: addwatchViewController = self.storyboard?.instantiateViewControllerWithIdentifier("addwatchViewController") as! addwatchViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alert.addAction(OKAction)
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

    

}
