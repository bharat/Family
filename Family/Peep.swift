
//  Peep.swift
//  Family
//
//  Created by Bharat Mediratta on 9/22/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class Peep {
    var name: String
    var address: [String] = []
    var lastUpdated: NSDate = NSDate()
    var observerCallback: (() -> Void)?
    var marker: GMSMarker = GMSMarker()
    
    init(name: String) {
        self.name = name
        
        // Simuator doesn't have a name
        if name.isEmpty {
            self.name = "Unknown"
        }

        self.marker.title = self.name
        self.marker.icon = UIImage(named: self.name)
    }

    func snippet() -> [String] {
        var copy = address
        copy.append("\(lastUpdated.toNaturalString(NSDate())!) ago")
        return copy
    }

    func stopObserving() {
        observerCallback = nil
    }
    
    func startObserving(callback: ()->Void) {
        observerCallback = callback
    }
    
    func setLocation(coords: CLLocationCoordinate2D) {
        lastUpdated = NSDate()
        marker.position = coords
        observerCallback?()
    }
    
    func setMap(map: GMSMapView) {
        marker.map = map
    }
}
