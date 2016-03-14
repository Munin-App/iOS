//
//  SignOutViewController.swift
//  Munin
//
//  Created by Mihir Singh on 3/13/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import UIKit
import KeychainSwift
import SwiftyUserDefaults

class SignOutViewController: UIViewController {
    @IBOutlet var confirmButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        confirmButton.addTarget(self, action: Selector("confirmedSignOut:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func confirmedSignOut(sender: UIButton) {
        let keychain = KeychainSwift()
        
        keychain.clear()
        
        Defaults.removeAll()
        
        self.performSegueWithIdentifier("segueToSignInView", sender: nil)
    }
}