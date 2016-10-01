//
//  TabBarController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/27/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class TabBarController: UITabBarController {
    var firstUpdate = true
    var peeps: Peeps!
    var store: Store!
    var locationService: LocationService!
    var selected: Peep?
    
    override func viewDidLoad() {
        Debug.print("TabBarController.viewDidLoad")
        locationService = LocationService()
        store = Store()
        peeps = Peeps(locationService: locationService, store: store)
    }
    
    func updateMe(coords: CLLocationCoordinate2D) {
        peeps.updateMe(coords)
        
        if firstUpdate {
            showMap()
            selectPeep(peeps.me)
            firstUpdate = false
        }
    }
    
    func selectPeep(peep: Peep) {
        selected = peep
        mapView().select(peep)
    }
    
    func showMap() {
        self.selectedIndex = 0
    }
    
    func showTable() {
        self.selectedIndex = 1
    }
    
    func mapView() -> MapViewController {
        return self.viewControllers![0] as! MapViewController
    }
    
    func startLocationTracking(cost: CostMode, success: ()->Void) {
        // Debug.print("--> Location tracking in \(cost) mode")
        locationService.start(cost) {
            location in
            self.updateMe(location.coordinate)
            success()
        }
    }
}