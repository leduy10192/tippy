//
//  ViewController.swift
//  tippy
//
//  Created by Duy Le on 12/19/19.
//  Copyright © 2019 Duy Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SettingsDelegate {

    

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func onTap(_ sender: Any) {
        print("Hello")
        
        view.endEditing(true)
    }
    @IBAction func calculateTip(_ sender: Any) {
        //Get the bill amount
        let bill = Double(billField.text!) ?? 0
        
        //Calculate the tip and total
        let tipPercentages = [0.1, 0.18, 0.2]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        //Update the tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f",total)
    }
    
    @IBAction func settingPressed(_ sender: Any) {
        performSegue(withIdentifier: "HomeToSetting", sender: self)
    }
    
    func didUpdateDefault(_ SettingViewController: SettingViewController, tipDefault: Int) {
        print("Ta", tipDefault)
        tipControl.selectedSegmentIndex = tipDefault
        totalLabel.text = "\(tipDefault)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToSetting" {
            let VC = segue.destination as! SettingViewController
            VC.delegate = self
        }
    }
}

