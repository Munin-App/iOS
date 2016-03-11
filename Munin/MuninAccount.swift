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


func requestAccountTokenWithPassword(username: String, password: String, callback: ((success: Bool)->Void)?) {
    var success = false

    let parameters = [
        "username": username,
        "password": password,
        "name": "Munin iOS - \(UIDevice.currentDevice().name)"
    ]

    Alamofire.request(.POST, "http://10.105.16.8:8000/tokens/", parameters: parameters)
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