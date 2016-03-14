//
//  AccountTableViewController.swift
//  Munin
//
//  Created by Mihir Singh on 3/13/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//


import UIKit
import XCGLogger
import SwiftyUserDefaults

class AccountTableViewController: UITableViewController {
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var tokenLabel: UILabel!
    @IBOutlet var hostLabel: UILabel!

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if let username = loadAccountInformation("username") as? String {
            usernameLabel.text = username
        }

        if let token = loadAccountInformation("token") as? String {
            tokenLabel.text = token
        }

        hostLabel.text = "api.muninapp.com"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}