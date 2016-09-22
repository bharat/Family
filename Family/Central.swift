//
//  Central.swift
//  Family
//
//  Created by Bharat Mediratta on 9/20/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class Central {
    static var c: Central = Central()
    var loc: LocationService = LocationService()
    var peeps: Peeps = Peeps()
    var me: Peep
    var mapVC: MapViewController?
    var tableVC: TableViewController?

    private init() {
        me = Peep(id: UIDevice.currentDevice().identifierForVendor!.UUIDString,
                  name: NSUserName(),
                  marker: GMSMarker())

        // Simuator doesn't have a name
        if me.name.isEmpty {
            me.name = "Me"
        }
    }
    
    func showPeepOnMap(peep: Peep) {
        // Switch to map view
        mapVC?.tabBarController?.selectedViewController = mapVC
        
        // Animate to the selected peep
        mapVC?.mapView.animateToLocation(peep.marker.position)
        mapVC?.mapView.animateToZoom(1)
    }
    
    // Add a new synthetic peep every 10 seconds
    static func addSyntheticLoop() {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(2 * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), {
                self.c.addPeep(SyntheticPeep())
                self.addSyntheticLoop()
            }
        )

    }
    
    func addPeep(peep: Peep) {
        peep.marker.map = mapVC?.mapView
        peeps.add(peep)
        update()
    }
    
    func update() {
        tableVC?.tableView.reloadData()
    }
    
    func locatedMyself(loc: CLLocation) {
        if me.marker.map == nil {
            // my marker was initialized before the MapViewController was ready
            me.marker.map = mapVC?.mapView
        }
        
        me.marker.position = loc.coordinate
        showPeepOnMap(me)
        update()
    }
    
    static func attach(vc: UIViewController) {
        if vc is MapViewController {
            c.mapVC = (vc as! MapViewController)
        } else {
            c.tableVC = (vc as! TableViewController)
        }
    }
}