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

enum CostMode {
    case Low
    case High
}

class LocationService {
    var request: Request?
    var geocoder: GMSGeocoder
    
    init() {
        geocoder = GMSGeocoder()

        // http://stackoverflow.com/questions/18901583/start-location-manager-in-ios-7-from-background-task
        // http://stackoverflow.com/questions/27564535/start-background-task-after-receiving-push-in-suspended-mode
    }
    
    func error(lastValidLocation: CLLocation?, error: LocationError) {
        Debug.print("Error \(error)")
        Debug.print("Last Valid \(lastValidLocation)")
        
        // Restart the same request again
        // self.start(cost!, firstCompletionCallback: firstCompletionCallback)
    }
    
    func start(cost: CostMode = .Low, success: (CLLocation) -> Void){
        Debug.print("Starting \(cost) location service")

        request?.cancel()

        request = Location.getLocation(
            withAccuracy: (cost == .High) ? .Navigation : .House,
            frequency: (cost == .High) ? .Continuous : .Significant,
            onSuccess: success,
            onError: error)
        
        request?.start()
    }
    
    func reverseGeocode(coords: CLLocationCoordinate2D, callback: (address: [String]) -> Void) {
        geocoder.reverseGeocodeCoordinate(coords) {
            response, error in
            var address: [String] = ["Unknown"]
            if let res = response?.firstResult() {
                address = res.lines! as [String]
            }
            callback(address: address)
        }
    }
}