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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.settings.tiltGestures = false
        mapView.animateToZoom(1)
        
        tbc().peeps.load()
    }
    
    override func viewDidAppear(animated: Bool) {
        tbc().peeps.setMapView(mapView)
        super.viewDidAppear(animated)
    }
    
    func tbc() -> TabBarController {
        return self.tabBarController as! TabBarController
    }
    
    func zoomTo(zoom: Float) {
        mapView.animateToZoom(zoom)
    }
    
    func select(peep: Peep) {
        // Animate to the selected peep and show its info box
        mapView.animateToLocation(peep.marker.position)
        mapView.selectedMarker = peep.marker
    }
    
    // MARK: GMSMapViewDelegate
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        NSUserDefaults.standardUserDefaults().setFloat(position.zoom, forKey: "MapZoom")
        position.zoom
    }
}

