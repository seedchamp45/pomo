//
//  HomekubViewController.swift
//  pomo
//
//  Created by Kittipol Munkatitum on 10/12/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit


class HomekubViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func call(sender: AnyObject) {
        self.callNumber("0836040557")
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL:NSURL = NSURL(string: "tel://\(phoneNumber)") {
            let application:UIApplication = UIApplication.sharedApplication()
            if (application.canOpenURL(phoneCallURL)) {
                application.openURL(phoneCallURL);
            }
        }
    }
  
    @IBAction func notification(sender: AnyObject) {
        // create the alert
        let alert = UIAlertController(title: "Notification", message: "is waiting for API", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // add the actions (buttons)
       alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
