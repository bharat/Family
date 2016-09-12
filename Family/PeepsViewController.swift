//
//  PeepsViewController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/11/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class PeepsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(LocationService.names())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

