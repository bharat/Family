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
    
    func load() {
        let url = "\(baseUrl)/load.php"
        Alamofire.request(.GET, url).responseData {
            response in
            if !response.result.isFailure {
                let data = String(data: response.result.value!, encoding: NSUTF8StringEncoding)
                let lines = data!.characters.split("\n").map(String.init)
                for line in lines {
                    let d = line.characters.split(" ").map(String.init)
                    Central.c.locatedOtherPeep(
                        d[0],
                        lastUpdated: NSDate(timeIntervalSince1970: Double(d[1])!),
                        coords: CLLocationCoordinate2D(
                            latitude: Double(d[2])!,
                            longitude: Double(d[3])!))
                }
            }
        }
    }
    
    func push(peep: Peep) {
        let p = peep.marker.position
        let url = "\(baseUrl)/save.php?name=\(peep.name)&lat=\(p.latitude)&long=\(p.longitude)"
        Alamofire.request(.GET, url).responseData {
            response in
            if !response.result.isFailure {
                let data = String(data: response.result.value!, encoding: NSUTF8StringEncoding)
                print(data)
            } else {
                print("Response failure: \(response.result)")
            }
        }
   }
}