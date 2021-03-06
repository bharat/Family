//
//  Store.swift
//  Family
//
//  Created by Bharat Mediratta on 9/23/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation
import Alamofire

class Store {
    var baseUrl = "http://menalto.com/family"
    
    func load(callback: (name: String, lastUpdated: NSDate, coords: CLLocationCoordinate2D) -> Void) {
        let url = "\(baseUrl)/load.php"
        Alamofire.request(.GET, url).responseData {
            response in
            if response.result.isFailure {
                Debug.print("Get response failure: \(response.result)")
            }  else {
                let data = String(data: response.result.value!, encoding: NSUTF8StringEncoding)
                // Debug.print("Get response \(data)")
                let lines = data!.characters.split("\n").map(String.init)
                for line in lines {
                    let d = line.characters.split(" ").map(String.init)
                    callback(
                        name: d[0],
                        lastUpdated: NSDate(timeIntervalSince1970: Double(d[1])!),
                        coords: CLLocationCoordinate2D(
                            latitude: Double(d[2])!,
                            longitude: Double(d[3])!))
                }
            }
        }
    }
    
    func save(peep: Peep) {
        let p = peep.marker.position
        let url = "\(baseUrl)/save.php?name=\(peep.name)&lat=\(p.latitude)&long=\(p.longitude)"
        Alamofire.request(.GET, url).responseData {
            response in
            if response.result.isFailure {
                Debug.print("Push response failure: \(response.result)")
            } else {
                // let data = String(data: response.result.value!, encoding: NSUTF8StringEncoding)
                // Debug.print("Push response \(data)")
            }
        }
   }
}