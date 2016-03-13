//
//  MetricAccount.swift
//  Status
//
//  Created by Mihir Singh on 3/8/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import UIKit
import Locksmith
import Alamofire
import XCGLogger


func requestAccountTokenWithPassword(username: String, password: String, callback: ((success: Bool)->Void)?) {
    var success = false

    let parameters = [
        "username": username,
        "password": password,
        "name": "Munin iOS - \(UIDevice.currentDevice().name)",
        "read_only": false
    ]

    Alamofire.request(.POST, "http://api.muninapp.com/tokens/", parameters: parameters as? [String : AnyObject])
        .responseJSON { response in
            debugPrint(response)

            let response = response.result.value as! NSDictionary

            if let token = response.objectForKey("token") as? String {
                success = true
                print(username)
                if !saveAccountInformation(["username": username, "token": token]) {
                    NSLog("Failed to save username to keychain")
                    success = false
                } else {
                    NSLog("Saved account information to the keychain")
                }
            }

            callback?(success: success)
    }
}

func userIsSignedIn() -> Bool {
    if loadAccountInformation("username") != nil {
        if loadAccountInformation("token") != nil {
            return true
        }
    }

    return false
}

func loadAccountInformation(key: String) -> AnyObject? {
    if let account = Locksmith.loadDataForUserAccount("munin") {
        if account[key] != nil {
            return account[key]
        }
    }
    
    return nil
}

func saveAccountInformation(dict: [String: AnyObject]) -> Bool {
    do {
        try Locksmith.updateData(dict, forUserAccount: "munin")
        return true
    } catch {
        return false
    }
}

func recordDataPoint(endpoint: String, data: [String: AnyObject], callback: ((success: Bool)->Void)?) {
    var success = false

    if let token = loadAccountInformation("token") as? String {
        let headers = [
            "X-Authorization": token
        ]

        debugPrint(data)
        debugPrint(headers)

        Alamofire.request(.POST, "http://api.muninapp.com/\(endpoint)/", parameters: data, headers: headers)
            .responseJSON { response in
                log.debug(response.debugDescription)
                log.info(response.description)

                callback?(success: success)
        }
    }
}