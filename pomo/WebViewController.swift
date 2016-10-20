//
//  WebViewController.swift
//  pomo
//
//  Created by Kittipol Munkatitum on 10/18/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate: class {
    func userDidEnterInformation(info: String)
}

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
      var urlWebsite: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("show")
        let defaults = UserDefaults.standard
         urlWebsite = defaults.string(forKey: "name")!
            print(urlWebsite)
            webView.loadRequest(NSURLRequest(url:NSURL(string: urlWebsite!)! as URL) as URLRequest)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
