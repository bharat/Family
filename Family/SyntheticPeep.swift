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
                   name: String.random(10, "A"..."Z"))
        
        self.setCoordinates(CLLocationCoordinate2D(
            latitude: CLLocationDegrees(Double.random(20.00...50.00)),
            longitude: CLLocationDegrees(Double.random(-130.00...(-70.00)))))
    }
    
}