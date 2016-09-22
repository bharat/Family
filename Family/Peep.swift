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
    var marker: GMSMarker
    var address: String?
    var geocoder: GMSGeocoder = GMSGeocoder()
    
    init(id: String, name: String, marker: GMSMarker) {
        self.id = id
        self.name = name
        self.marker = marker
        self.geocoder = GMSGeocoder()
    }
    
    func setLocation(location: CLLocation) {
        marker.position = location.coordinate
        geocoder.reverseGeocodeCoordinate(marker.position) { response, error in
            if let address = response?.firstResult() {
                let lines = address.lines! as [String]
                self.address = lines.joinWithSeparator("\n")
            }
        }
    }
}
