//
//  PeepsViewController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/11/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!

    override func viewDidAppear(animated: Bool) {
        tbc().peeps.load()
    }
    
    func tbc() -> TabBarController {
        return self.tabBarController as! TabBarController
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tbc().showMap(tbc().peeps.get(indexPath.row))
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tbc().peeps.count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LilPeeper")! as UITableViewCell
        let peep = tbc().peeps.get(indexPath.row)
        cell.textLabel?.text = peep.name
        cell.detailTextLabel?.text = peep.snippet()
        return cell
    }
}

