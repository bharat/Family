//
//  SyntheticPeep.swift
//  Family
//
//  Created by Bharat Mediratta on 9/22/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class SyntheticPeep: Peep {
    
    init() {
        super.init(id: String.random(10, "A"..."Z"),
                   name: String.random(10, "A"..."Z"),
                   marker: GMSMarker(position: CLLocationCoordinate2D(
                    latitude: CLLocationDegrees(Double.random(-180...180)),
                    longitude: CLLocationDegrees(Double.random(-180.00...180.00)))))
    }
    
}