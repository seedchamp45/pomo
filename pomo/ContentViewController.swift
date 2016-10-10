//
//  ContentViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/9/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
   



    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func sendtoLogin(sender: AnyObject) {
    }
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    @IBAction func sendtoLoginNavigation(sender: AnyObject) {
        let vc:loginNavigationController = self.storyboard?.instantiateViewControllerWithIdentifier("loginNavigationController") as! loginNavigationController
        self.presentViewController(vc, animated: true, completion: nil)
        print("eiei")
        
    
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        self.imageView.image = UIImage(named: self.imageFile)
        self.titleLabel.text = self.titleText
        if pageIndex > 0 {
            button.hidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
