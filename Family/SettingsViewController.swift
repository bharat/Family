//
//  SettingsViewController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/23/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class SettingsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet var password: UIView!
    @IBOutlet var code: UITextField!
    @IBOutlet var settings: UIView!
    @IBOutlet var userName: UIButton!
    @IBOutlet var debugText: UITextView!
    @IBOutlet var debugAutoScrollSwitch: UISwitch!
    
    var debugLinesDisplayed: Int = 0
    
    let userNames = ["Ally", "Bettina", "Bharat", "Cole"]
    
    override func viewDidLoad() {
        password.hidden = false
        code.text = ""
        code.becomeFirstResponder()
        
        settings.hidden = true
        debugAutoScrollSwitch.setOn(true, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        userName.setTitle(tbc().peeps.me.name, forState: .Normal)
        Debug.startObserving(self.updateDebug)
        updateDebug()
    }
    
    override func viewDidDisappear(animated: Bool) {
        Debug.stopObserving()
    }
    
    func updateDebug() -> Void {
        if Debug.lines.count > debugLinesDisplayed {
            let sliceToAdd = Debug.lines[debugLinesDisplayed...Debug.lines.count-1]
            debugText.text.appendContentsOf("\n" + sliceToAdd.joinWithSeparator("\n"))
            debugLinesDisplayed += sliceToAdd.count
        }

        if debugAutoScrollSwitch.on {
            debugText.scrollRangeToVisible(NSMakeRange(debugText.text.characters.count - 1, 1))
        }
    }

    func tbc() -> TabBarController {
        return self.tabBarController as! TabBarController
    }

    @IBAction func lockSettings(sender: AnyObject) {
        settings.hidden = true
        password.hidden = false
        code.text = ""
        tbc().showTable()
    }
    
    @IBAction func chooseUser(sender: AnyObject) {
        let userMenu = UIAlertController(title: nil, message: "Choose User", preferredStyle: .ActionSheet)
        
        for name in userNames {
            userMenu.addAction(UIAlertAction(title: name, style: .Default, handler: {
                alert in
                self.userName.setTitle(name, forState: .Normal)
                
                // should quit/restart app at this point
                NSUserDefaults.standardUserDefaults().setValue(name, forKeyPath: "UserName")
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

