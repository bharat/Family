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
    var request: Request?
    var geocoder: GMSGeocoder!
    var successCallback: (CLLocation) -> Void
    
    init(callback: (CLLocation) -> Void) {
        geocoder = GMSGeocoder()
        self.successCallback = callback

        //  http://stackoverflow.com/questions/18901583/start-location-manager-in-ios-7-from-background-task
        // http://stackoverflow.com/questions/27564535/start-background-task-after-receiving-push-in-suspended-mode
    }
    
    func error(lastValidLocation: CLLocation?, error: LocationError) {
        print("Error \(error)")
        print("Last Valid \(lastValidLocation)")
        
        request?.start()
    }
    
    func startLowCost() {
        print("Starting low cost location service")
        
        request?.cancel()
        request = Location.getLocation(withAccuracy: .House,
                                       frequency: .Significant,
                                       onSuccess: successCallback,
                                       onError: error)
        
        request?.start()
    }
        
    func startHighCost(firstCompletionCallback: ()->Void) {
        print("Starting high cost location service")
        
        request?.cancel()
        request = Location.getLocation(withAccuracy: .Navigation,
                                       frequency: .Continuous,
                                       onSuccess: {
                                         location in
                                         self.successCallback(location)
                                         firstCompletionCallback()
                                       },
                                       onError: error)
        
        request?.start()
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