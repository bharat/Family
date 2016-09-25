//
//  SettingsViewController.swift
//  Family
//
//  Created by Bharat Mediratta on 9/23/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//

import Foundation

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet var peepPicker: UIPickerView!
    @IBOutlet var lock: UISwitch!
    @IBOutlet var code: UITextField!
    let pickerData = ["Ally", "Bettina", "Bharat", "Cole"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        lock.setOn(true, animated: true)
        peepPicker.userInteractionEnabled = !lock.on
        peepPicker.selectRow(pickerData.indexOf(Central.c.me.name)!, inComponent: 0, animated: true)
        code.text = ""
    }

    @IBAction func lockValueChanged(sender: UISwitch) {
        if !lock.on && code.text != "kakao" {
            lock.setOn(true, animated: true)
            return
        }

        peepPicker.userInteractionEnabled = !lock.on
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
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

