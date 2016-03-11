//
//  MainViewController.swift
//  Munin
//
//  Created by Mihir Singh on 3/10/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UITabBarController {
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !userIsSignedIn() {
            self.performSegueWithIdentifier("segueToSignInView", sender: nil)
        }
    }
}