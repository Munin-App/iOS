//
//  ViewController.swift
//  Status
//
//  Created by Mihir Singh on 3/5/16.
//  Copyright © 2016 Mihir Singh. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import XCGLogger

class MapView: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var mapView: MKMapView!
    
    var locationManager:CLLocationManager?
    var formatterISO8601: NSDateFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self;
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
            locationManager?.distanceFilter = kCLDistanceFilterNone;
            locationManager?.pausesLocationUpdatesAutomatically = false;
            locationManager?.requestWhenInUseAuthorization();
            locationManager?.requestAlwaysAuthorization();
            locationManager?.allowsBackgroundLocationUpdates = true;
            locationManager?.startUpdatingLocation();
            
        }
        
        formatterISO8601 = {
            let formatter = NSDateFormatter()
            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
            return formatter
        }()
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation = locations.last!
        
        logLocation(latestLocation.coordinate.latitude, longitude: latestLocation.coordinate.longitude)
    }
    
    func logLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        log.info("Location Updated: \(latitude), \(longitude)")
        
        let timestamp = formatterISO8601?.stringFromDate(NSDate())

        latitudeLabel.text = latitude.description
        longitudeLabel.text = longitude.description

        var mapRegion = MKCoordinateRegion();
        
        mapRegion.center = mapView.userLocation.coordinate;
        mapRegion.span.latitudeDelta = 0.005
        mapRegion.span.longitudeDelta = 0.005
        
        mapView.setRegion(mapRegion, animated: true)
        
        let data = [
            "timestamp": timestamp!,
            "latitude": latitude,
            "longitude": longitude
        ]
        
        recordDataPoint("locations", data: data as! [String: AnyObject])  { (success) -> Void in
            print(success)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}