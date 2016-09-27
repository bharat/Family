//
//  SettingsViewController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/23/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    @IBOutlet var password: UIView!
    @IBOutlet var code: UITextField!
    
    @IBOutlet var settings: UIView!
    @IBOutlet var peepPicker: UIPickerView!
    let pickerData = ["Ally", "Bettina", "Bharat", "Cole"]
    
    
    override func viewDidAppear(animated: Bool) {
        settings.hidden = true
        password.hidden = false
        
        code.text = ""
        peepPicker.selectRow(pickerData.indexOf(Central.c.me.name)!, inComponent: 0, animated: true)
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
    
    // MARK: UIPickerViewDataSource
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // MARK: UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Central.c.changeUser(pickerData[row])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

