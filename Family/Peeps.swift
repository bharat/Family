//
//  Peeps.swift
//  Family
//
//  Created by Bharat Mediratta on 9/22/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class Peeps {
    var me: Peep
    var peeps: [String: Peep] = [:]
    var mapView: GMSMapView?
    var count: Int {
        return Array(peeps.values).count
    }
    
    init() {
        me = Peep(id: UIDevice.currentDevice().identifierForVendor!.UUIDString,
                  name: NSUserName(),
                  marker: GMSMarker())
        
        // Simuator doesn't have a name
        if me.name.isEmpty {
            me.name = "Me"
        }
        
        peeps[me.id] = me
    }
    
    func setMapView(mapView: GMSMapView) {
        for peep in peeps.values {
            peep.marker.map = mapView
        }
    }
    
    func setMyLocation(loc: CLLocation) {
        me.setLocation(loc)
    }
    
    subscript(i: Int) -> Peep {
        return Array(peeps.values)[i]
    }
}