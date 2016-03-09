//
//  SignInController.swift
//  Munin
//
//  Created by Mihir Singh on 3/9/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import UIKit

class SignInView: UIViewController, UITextFieldDelegate {
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func signIn() {
        print("Signing In")
    }
}
    