//
//  LocationManager.swift
//  Munin
//
//  Created by Mihir Singh on 3/13/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import CoreLocation
import SwiftyUserDefaults

class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    dynamic var currentLocation: CLLocation?

    let preference_location_enabled = DefaultsKey<Bool>("location_service_enabled")
    var enabled: Bool = false

    func setup() {
        locationManager = CLLocationManager()

        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self;
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager?.distanceFilter = kCLDistanceFilterNone;
            locationManager?.pausesLocationUpdatesAutomatically = false;
            locationManager?.requestWhenInUseAuthorization();
            locationManager?.requestAlwaysAuthorization();
            locationManager?.allowsBackgroundLocationUpdates = true;
        }

        if Defaults[preference_location_enabled] {
            enabled = true
            locationManager?.startUpdatingLocation();
        }
    }

    func enableService() {
        locationManager?.startUpdatingLocation()
        Defaults[preference_location_enabled] = true
        enabled = true
    }

    func disableService() {
        locationManager?.stopUpdatingLocation()
        Defaults[preference_location_enabled] = false
        enabled = false
    }


    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let latestLocation = locations.last {
            currentLocation = latestLocation

            let timestamp = formatterISO8601?.stringFromDate(NSDate())

            var data: [String: AnyObject]

            data = [
                "timestamp": timestamp!,
                "latitude": latestLocation.coordinate.latitude,
                "longitude": latestLocation.coordinate.longitude
            ]

            recordDataPoint("locations", data: data)  { (success) -> Void in
                print(success)
            }
        }
    }
}