//
//  Peep.swift
//  Family
//
//  Created by Bharat Mediratta on 9/22/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class Peep {
    var name: String
    var marker: GMSMarker = GMSMarker()
    var address: String = ""
    var lastUpdated: NSDate?
    
    init(name: String) {
        self.name = name
        
        // Simuator doesn't have a name
        if name.isEmpty {
            self.name = "Unknown"
        }
        
        self.marker.title = self.name
        self.marker.icon = UIImage(named: self.name)
    }
    
    func setCoordinates(location: CLLocationCoordinate2D) {
        marker.position = location
        
        Central.c.reverseGeocode(marker.position) {
            address in
            self.marker.snippet = address
            self.address = address
            Central.c.update()
        }
    }
}
