//
//  SyntheticPeep.swift
//  Family
//
//  Created by Bharat Mediratta on 9/22/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation
import RandomKit

class SyntheticPeep: Peep {
    
    override init(name: String) {
        super.init(name: name)
        
        self.setCoordinates(CLLocationCoordinate2D(
            latitude: CLLocationDegrees(Double.random(20.00...50.00)),
            longitude: CLLocationDegrees(Double.random(-130.00...(-70.00)))))
        self.marker.icon = UIImage(named: name)
    }
    
}