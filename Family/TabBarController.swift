//
//  TabBarController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/27/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class TabBarController: UITabBarController {
    var peeps: Peeps!
    var store: Store!
    var locationService: LocationService!
    
    override func viewDidLoad() {
        print("TabBarController.viewDidLoad")
        locationService = LocationService() {
            location in
            self.peeps.updateMe(location.coordinate)
        }
        store = Store()
        peeps = Peeps(locationService: locationService, store: store)
    }
    
    func showMap(peep: Peep) {
        self.selectedIndex = 0
        (self.viewControllers![0] as! MapViewController).select(peep)
    }
    
    func showTable() {
        self.selectedIndex = 1
    }
    
    func changeUser(name: String) {
        peeps.changeUser(name)
    }
}