//
//  ViewController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/11/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, GMSMapViewDelegate {
    @IBOutlet var mapView: GMSMapView! {
        didSet {
            Central.c.updateMapView(mapView)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.settings.tiltGestures = false
        
        var zoom = NSUserDefaults.standardUserDefaults().floatForKey("MapZoom")
        if zoom == 0 {
            zoom = 15
        }
        mapView.animateToZoom(zoom)

        Central.c.attach(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        Central.c.getLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: GMSMapViewDelegate
    func mapView(mapView: GMSMapView, idleAtCameraPosition position: GMSCameraPosition) {
        NSUserDefaults.standardUserDefaults().setFloat(position.zoom, forKey: "MapZoom")
        position.zoom
    }
}

