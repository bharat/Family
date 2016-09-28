//
//  Location.swift
//  Family
//
//  Created by Bharat Mediratta on 9/11/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation
import SwiftLocation
import CoreLocation

class LocationService {
    var request: Request!
    var geocoder: GMSGeocoder!
    
    init(callback: (CLLocation) -> Void) {
        geocoder = GMSGeocoder()
        request = Location.getLocation(withAccuracy: .House, onSuccess: callback, onError: error)
        request.start()
    }
    
    func error(lastValidLocation: CLLocation?, error: LocationError) {
        print("Error \(error)")
        print("Last Valid \(lastValidLocation)")
    }
    
    func start() {
        request.start()
    }
        
    func stop() {
        request.cancel()
    }
    
    func reverseGeocode(coords: CLLocationCoordinate2D, callback: (address: String) -> Void) {
        geocoder.reverseGeocodeCoordinate(coords) {
            response, error in
            var address: String! = "Unknown"
            if let res = response?.firstResult() {
                let lines = res.lines! as [String]
                address = lines.joinWithSeparator("\n")
            }
            callback(address: address)
        }
    }
}