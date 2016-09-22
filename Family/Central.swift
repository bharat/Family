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
    var mapVC: MapViewController?
    var peepsVC: PeepsViewController?
    
    
    func selectPeep(peep: Peep) {
        mapVC?.tabBarController?.selectedViewController = mapVC
        mapVC?.mapView.animateToLocation(peep.marker.position)
        mapVC?.mapView.animateToZoom(15)
    }
    
    func locatedMyself(loc: CLLocation) {
        peeps.setMyLocation(loc)
        
        if mapVC?.tabBarController!.selectedViewController == mapVC {
            selectPeep(peeps.me)
        }
        peepsVC?.tableView.reloadData()
    }
    
    static func attach(vc: UIViewController) {
        if vc is MapViewController {
            c.mapVC = (vc as! MapViewController)
            c.peeps.setMapView((c.mapVC?.mapView)!)
        } else {
            c.peepsVC = (vc as! PeepsViewController)
        }
    }
}