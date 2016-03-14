//
//  LocationTableViewController.swift
//  Munin
//
//  Created by Mihir Singh on 3/13/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

//
//  ViewController.swift
//  Status
//
//  Created by Mihir Singh on 3/5/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import UIKit
import XCGLogger
import SwiftyUserDefaults

class LocationTableViewController: UITableViewController {
    private var kvoContext: UInt8 = 1
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!

    @IBOutlet var enabledSwitch: UISwitch!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        enabledSwitch.addTarget(self, action: Selector("enableSwitchToggled:"), forControlEvents: UIControlEvents.ValueChanged)
        enabledSwitch.setOn(locationData.enabled, animated: true)
        
        if !locationData.enabled {
            latitudeLabel.text = "Disabled"
            longitudeLabel.text = "Disabled"
        }

        locationData.addObserver(self, forKeyPath: "currentLocation", options: NSKeyValueObservingOptions([.New, .Old]), context: &kvoContext)
    }

    func enableSwitchToggled(switchState: UISwitch) {
        if switchState.on {
            locationData.enableService()
            latitudeLabel.text = "Loading"
            longitudeLabel.text = "Loading"
        } else {
            locationData.disableService()
            latitudeLabel.text = "Disabled"
            longitudeLabel.text = "Disabled"
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        locationData.removeObserver(self, forKeyPath: "currentLocation")
    }

    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &kvoContext {
            if let coordinate = locationData.currentLocation?.coordinate {
                latitudeLabel.text = coordinate.latitude.description
                longitudeLabel.text = coordinate.longitude.description
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}