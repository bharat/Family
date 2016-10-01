//
//  Debug.swift
//  Family
//
//  Created by Bharat Mediratta on 9/29/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation
import SwiftDate

class Debug {
    static var lines: [String] = []
    static var fmt: NSDateFormatter = NSDateFormatter()
    static var observer: () -> Void = Debug.ignore
    static var dateMarker: NSDate? = nil
    
    static func print(str: String) {
        let now = NSDate()
        
        if dateMarker == nil || dateMarker?.day < now.day {
            let dateString = now.toString(.Custom("M/d/YYYY"), inRegion: nil)
            dateMarker = now
            lines.append("=== \(dateString!) ===")
        }
        
        let timeString = now.toString(.Custom("HH:mm:ss"), inRegion: nil)
        lines.append("\(timeString!): \(str)")
        
        observer()
    }
    
    static func startObserving(callback: () -> Void) {
        observer = callback
    }
    
    static func ignore() {
    }
    
    static func stopObserving() {
        observer = Debug.ignore
    }
}