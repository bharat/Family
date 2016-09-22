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
                  name: NSUserName())

        addPeep(me)
    }
    
    static func attach(vc: UIViewController) {
        if vc is MapViewController {
            c.mapVC = (vc as! MapViewController)
        } else {
            c.tableVC = (vc as! TableViewController)
        }
    }
    
    func switchToMap() {
        mapVC?.tabBarController?.selectedViewController = mapVC
    }
    
    func selectPeep(peep: Peep) {
        // Animate to the selected peep and show its info box
        mapVC?.mapView.animateToLocation(peep.marker.position)
        mapVC?.mapView.selectedMarker = peep.marker
    }
    
    func addPeep(peep: Peep) {
        peep.marker.map = mapVC?.mapView
        peeps.add(peep)
        update()
    }
    
    func update() {
        tableVC?.tableView.reloadData()
    }
    
    func locatedMyself(coords: CLLocationCoordinate2D) {
        if me.marker.map == nil {
            // my marker was initialized before the MapViewController was available,
            // so fix it up now.
            me.marker.map = mapVC?.mapView
        }
        
        me.setCoordinates(coords)
        switchToMap()
        selectPeep(me)
        update()
    }
    
    // Add a new synthetic peep every 10 seconds
    static func addSyntheticLoop() {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(10 * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), {
                self.c.addPeep(SyntheticPeep())
                self.addSyntheticLoop()
            }
        )
        
    }
}