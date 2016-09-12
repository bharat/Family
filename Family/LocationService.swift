//
//  Location.swift
//  Family
//
//  Created by Bharat Mediratta on 9/11/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation
import SwiftLocation
import CoreLocation

class LocationService {
    var request: Request!
    static let singleton = LocationService()
    var mapView: GMSMapView?
    var markers: [String: GMSMarker] = [:]
    var initialView = true
    var shouldShowLocation = true
    var name = NSUserName()
    
    private init() {
        print("LocationService init")
        request = Location.getLocation(withAccuracy: .House, onSuccess: success, onError: error)
        if name.isEmpty {
            name = "Unknown"
        }
        print("LocationService init [done]")
    }
    
    func success(foundLocation: CLLocation) {
        print("Found: \(foundLocation)")
        if markers[name] == nil {
            let marker = GMSMarker()
            print("My name is \(name)")
            marker.title = name
            marker.position = foundLocation.coordinate
            marker.map = mapView
            markers[name] = marker
        } else {
            markers[name]?.position = foundLocation.coordinate
        }

        if shouldShowLocation {
            mapView?.animateToLocation(markers[name]!.position)
            mapView?.animateToZoom(15)
            shouldShowLocation = false
        }
        
        print("Found: \(foundLocation) [done]")
    }
    
    func error(lastValidLocation: CLLocation?, error: LocationError) {
        print("Error \(error)")
        print("Last Valid \(lastValidLocation)")
    }
    
    static func start() {
        singleton.request.start()
        singleton.shouldShowLocation = true
    }
    
    static func stop() {
        singleton.request.cancel()
    }
    
    static func names() -> [String] {
        return Array(singleton.markers.keys)
    }
    
    static func setMapView(mapView: GMSMapView) {
        singleton.mapView = mapView
    }
}