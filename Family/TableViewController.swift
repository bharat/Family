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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Central.c.attach(self)
    }

    override func viewDidAppear(animated: Bool) {
        Central.c.getLocations()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let peep = Array(Central.c.peeps.values)[indexPath.row]
        Central.c.switchToMap()
        Central.c.selectPeep(peep)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Central.c.peeps.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LilPeeper")! as UITableViewCell
        let peep = Array(Central.c.peeps.values)[indexPath.row]
        cell.textLabel?.text = peep.name
        cell.detailTextLabel?.text = peep.address
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

