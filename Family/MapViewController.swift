//
//  ViewController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/11/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, GMSMapViewDelegate {
    @IBOutlet var mapView: GMSMapView!
    var selected: Peep?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.settings.tiltGestures = false
        mapView.animateToZoom(15)
        
        tbc().peeps.load()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tbc().peeps.setMapView(mapView)
    }
    
    func tbc() -> TabBarController {
        return self.tabBarController as! TabBarController
    }
    
    func zoomTo(zoom: Float) {
        mapView.animateToZoom(zoom)
    }
    
    func select(peep: Peep) {
        selected?.stopObserving()

        mapView.selectedMarker = peep.marker
        mapView.animateToLocation(peep.marker.position)
        
        peep.startObserving() {
            self.mapView.animateToLocation(peep.marker.position)
        }
        selected = peep
    }
        
    // MARK: GMSMapViewDelegate
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        position.zoom
    }
}

