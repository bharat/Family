//
//  Peeps.swift
//  Family
//
//  Created by Bharat Mediratta on 9/27/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class Peeps {
    var me: Peep!
    private let loc: LocationService!
    private let store: Store!
    private var data: [String: Peep] = [:]

    init(locationService: LocationService, store: Store) {
        var name = NSUserDefaults.standardUserDefaults().stringForKey("UserName")
        if name == nil {
            name = "Bharat" // got start somewhere
        }
        
        me = Peep(name: name!)
        data[me.name] = me
        self.loc = locationService
        self.store = store
    }

    func load() {
        store.load(self.updatePeep)
    }
    
    func updateMe(coords: CLLocationCoordinate2D) {
        me.lastUpdated = NSDate()
        me.marker.position = coords
        store.save(me)
    }
    
    func updatePeep(name: String, lastUpdated: NSDate, coords: CLLocationCoordinate2D) {
        if name == me.name {
            // This is only for loading other peeps
            return
        }
        
        var p: Peep?
        p = data[name]
        
        if p == nil {
            p = Peep(name: name)
            data[name] = p
        }
        
        p!.lastUpdated = lastUpdated
        p!.marker.position = coords
        loc.reverseGeocode(coords) {
            address in
            p!.address = address
        }
    }
    
    func setMapView(mapView: GMSMapView) {
        for p in data.values {
            p.marker.map = mapView
        }
    }
    
    func get(index: Int) -> Peep {
        return Array(data.values)[index]
    }
    
    func count() -> Int {
        return data.count
    }
    
    func changeUser(name: String) {
        for peep in data.values {
            peep.marker.map = nil
        }
        data.removeAll()
        
        me = Peep(name: name)
        data[me.name] = me
        NSUserDefaults.standardUserDefaults().setValue(name, forKeyPath: "UserName")
    }
}