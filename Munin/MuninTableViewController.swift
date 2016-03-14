//
//  MuninTableViewController.swift
//  Munin
//
//  Created by Mihir Singh on 3/13/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import UIKit
import XCGLogger
import SwiftyUserDefaults

class MuninTableViewController: UITableViewController {
    @IBOutlet var usernameLabel: UILabel!

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if let username = loadAccountInformation("username") as? String {
            usernameLabel.text = username
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}