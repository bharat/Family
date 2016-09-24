//
//  ViewController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/11/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    @IBOutlet var mapView: GMSMapView! {
        didSet {
            Central.c.updateMapView(mapView)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.animateToZoom(4)

        Central.c.attach(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        Central.c.getLocations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

