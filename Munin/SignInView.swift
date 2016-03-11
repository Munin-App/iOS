//
//  SignInController.swift
//  Munin
//
//  Created by Mihir Singh on 3/9/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import UIKit
import Alamofire

class SignInView: UIViewController, UITextFieldDelegate {
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if userIsSignedIn() {
            self.performSegueWithIdentifier("showMainApplication", sender: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func signIn() {
        if let username = usernameField.text {
            if let password = passwordField.text {
                requestAccountTokenWithPassword(username, password: password) { (success) -> Void in
                    if success {
                        self.performSegueWithIdentifier("showMainApplication", sender: nil)
                    }
                }
            }
        }
    }
}
