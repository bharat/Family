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
    
    init() {
        request = Location.getLocation(withAccuracy: .House, onSuccess: success, onError: error)
    }
    
    func success(foundLocation: CLLocation) {
        Central.c.locatedMyself(foundLocation)
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
}