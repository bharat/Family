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
    var peeps: [String: Peep] = [:]
    var me: Peep
    var mapVC: MapViewController?
    var tableVC: TableViewController?

    private init() {
        me = Peep(name: "Bharat")
        addPeep(me)
    }
    
    func attach(vc: UIViewController) {
        if vc is MapViewController {
            mapVC = (vc as! MapViewController)
        } else {
            tableVC = (vc as! TableViewController)
        }
    }
    
    func switchToMap() {
        mapVC?.tabBarController?.selectedViewController = mapVC
    }
    
    func changeUser(name: String) {
        for peep in peeps.values {
            peep.marker.map = nil
        }
        peeps.removeAll()
        me = Peep(name: name)
        addPeep(me)
        loc.stop()
        loc.start()
    }
    
    func selectPeep(peep: Peep) {
        // Animate to the selected peep and show its info box
        mapVC?.mapView.animateToLocation(peep.marker.position)
        mapVC?.mapView.selectedMarker = peep.marker
    }
    
    func addPeep(peep: Peep) {
        peep.marker.map = mapVC?.mapView
        peeps[peep.name] = peep
        update()
    }
    
    func update() {
        tableVC?.tableView.reloadData()
    }
    
    func updateMapView(mapView: GMSMapView!) {
        for peep in peeps.values {
            peep.marker.map = mapView
        }
    }
    
    func locatedMyself(coords: CLLocationCoordinate2D) {
        me.setCoordinates(coords)
        switchToMap()
        selectPeep(me)
        
        update()
    }
}