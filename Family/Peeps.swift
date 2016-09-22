//
//  Peeps.swift
//  Family
//
//  Created by Bharat Mediratta on 9/22/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation
import RandomKit

class Peeps {
    var peeps: [String: Peep] = [:]
    var count: Int {
        return Array(peeps.values).count
    }
    
    func add(peep: Peep) {
        peeps[peep.id] = peep
    }
    
    subscript(i: Int) -> Peep {
        return Array(peeps.values)[i]
    }
}