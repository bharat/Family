//
//  ViewController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/11/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    @IBOutlet var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.settings.compassButton = true
        mapView.settings.myLocationButton = true
        mapView.animateToZoom(4)

        Central.attach(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

