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

class LocationTableViewController: UITableViewController {
    private var kvoContext: UInt8 = 1
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        locationData.addObserver(self, forKeyPath: "currentLocation", options: NSKeyValueObservingOptions([.New, .Old]), context: &kvoContext)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        locationData.removeObserver(self, forKeyPath: "currentLocation")
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print("Value change observed!")
        if context == &kvoContext {
            if let coordinate = locationData.currentLocation?.coordinate {
                latitudeLabel.text = coordinate.latitude.description
                longitudeLabel.text = coordinate.longitude.description
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}