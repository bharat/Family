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
    
    override func viewDidLoad() {
        print("TabBarController.viewDidLoad")
        locationService = LocationService() {
            location in
            self.updateMe(location.coordinate)
        }
        store = Store()
        peeps = Peeps(locationService: locationService, store: store)
    }
    
    func updateMe(coords: CLLocationCoordinate2D) {
        peeps.updateMe(coords)
        
        if firstUpdate {
            showMap(peeps.me)
            firstUpdate = false
        
            mapView().zoomTo(NSUserDefaults.standardUserDefaults().floatForKey("MapZoom"))
        }
    }
    
    func showMap(peep: Peep) {
        self.selectedIndex = 0
        mapView().select(peep)
    }
    
    func showTable() {
        self.selectedIndex = 1
    }
    
    func mapView() -> MapViewController {
        return self.viewControllers![0] as! MapViewController
    }
    
    func changeUser(name: String) {
        peeps.changeUser(name)
    }
    
    func enterHighMode(callback: ()->Void) {
        print("--> HIGH MODE")
        locationService.startHighCost(callback)
    }

    func enterLowMode() {
        print("--> LOW MODE")
        locationService.startLowCost()
    }
}