//
//  enterOTPViewController.swift
//  pomo
//
//  Created by Thanawith Munkatitum on 10/10/2559 BE.
//  Copyright © 2559 Kittipol Munkatitum. All rights reserved.
//

import UIKit
import SmileLock

class enterOTPViewController: UIViewController {

    
    @IBOutlet weak var passwordStackView: UIStackView!
    
    //MARK: Property
    var passwordContainerView: PasswordContainerView!
    let kPasswordDigit = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create PasswordContainerView
        passwordContainerView = PasswordContainerView.create(in: passwordStackView, digit: kPasswordDigit)
        passwordContainerView.delegate = self
        
        //customize password UI
        passwordContainerView.tintColor = UIColor.color(.textColor)
        passwordContainerView.highlightedColor = UIColor.color(.blue)
    }
}

extension enterOTPViewController: PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if validation(input) {
            validationSuccess()
        } else {
            validationFail()
        }
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: NSError?) {
        if success {
            self.validationSuccess()
        } else {
            passwordContainerView.clearInput()
        }
    }
}

private extension enterOTPViewController {
    func validation(_ input: String) -> Bool {
        return input == "123456"
    }
    
    func validationSuccess() {
        print("*️⃣ success!")
        let vc: enterPasswordViewController = self.storyboard?.instantiateViewController(withIdentifier: "enterPasswordViewController") as! enterPasswordViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func validationFail() {
        print("*️⃣ failure!")
        passwordContainerView.wrongPassword()
    }
}
