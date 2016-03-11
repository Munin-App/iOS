//
//  MetricAccount.swift
//  Status
//
//  Created by Mihir Singh on 3/8/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import Locksmith

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