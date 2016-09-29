//
//  SettingsViewController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/23/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class SettingsViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    @IBOutlet var password: UIView!
    @IBOutlet var code: UITextField!

    @IBOutlet var settings: UIView!
    @IBOutlet var userName: UIButton!
    
    let userNames = ["Ally", "Bettina", "Bharat", "Cole"]
    
    override func viewWillAppear(animated: Bool) {
        password.hidden = false
        code.text = ""
        
        settings.hidden = true
        userName.setTitle(tbc().peeps.me.name, forState: .Normal)
    }

    func tbc() -> TabBarController {
        return self.tabBarController as! TabBarController
    }

    @IBAction func chooseUser(sender: AnyObject) {
        let userMenu = UIAlertController(title: nil, message: "Choose User", preferredStyle: .ActionSheet)
        
        for name in userNames {
            userMenu.addAction(UIAlertAction(title: name, style: .Default, handler: {
                alert in
                self.userName.setTitle(name, forState: .Normal)
                self.tbc().changeUser(name)
            }))
        }
        userMenu.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: {alert in}))
        self.presentViewController(userMenu, animated: true, completion: nil)
    }
    
    // MARK: UIPickerViewDelegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        code.resignFirstResponder()
        if code.text == "kakao" {
            password.hidden = true
            settings.hidden = false
        }
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

