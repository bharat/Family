//
//  Peep.swift
//  Family
//
//  Created by Bharat Mediratta on 9/22/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class Peep {
    var id: String
    var name: String
    var marker: GMSMarker = GMSMarker()
    var address: String?
    var geocoder: GMSGeocoder = GMSGeocoder()
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        self.geocoder = GMSGeocoder()
        
        // Simuator doesn't have a name
        if name.isEmpty {
            self.name = "Unknown"
        }
        
        self.marker.title = self.name
    }
    
    func setCoordinates(location: CLLocationCoordinate2D) {
        marker.position = location
        geocoder.reverseGeocodeCoordinate(marker.position) { response, error in
            self.address = "Unknown"
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                self.address = lines.joinWithSeparator("\n")
            }
            
            self.marker.snippet = self.address
            Central.c.update()
        }
    }
}
