//
//  MuninNavigationController.swift
//  Munin
//
//  Created by Mihir Singh on 3/13/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import UIKit

class MuninNavigationController: UINavigationController {
    override func viewWillAppear(animated: Bool) {
        if userIsSignedIn() {
            super.viewWillAppear(animated)

            locationData.setup()
        } else {
            self.performSegueWithIdentifier("segueToSignInView", sender: nil)
        }
    }
}
