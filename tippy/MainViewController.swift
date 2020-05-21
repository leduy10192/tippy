//
//  ViewController.swift
//  tippy
//
//  Created by Duy Le on 12/19/19.
//  Copyright © 2019 Duy Le. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, SettingsDelegate{

    

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var myView: UITextField!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        secondView.alpha = 0
        billField.delegate = self
        billField.becomeFirstResponder()
        billField.addTarget(self, action: #selector(MainViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        let bill = defaults.double(forKey: "billAmount")
        let tipDefault = defaults.integer(forKey: "tipDefault")
        if bill == 0.00 {
            billField.text = ""
        }else{
            billField.text = String(format: "%.2f", bill)
        }
        tipControl.selectedSegmentIndex = tipDefault
        updateUI()
    }
    

    @IBAction func onTap(_ sender: Any) {
        print("Hello")
        
        view.endEditing(true)
    }
    @IBAction func calculateTip(_ sender: Any) {
        //Get the bill amount
        let bill = updateUI()
        
        defaults.set(bill, forKey: "billAmount")
    }
    
    func updateUI() -> Double{
        let bill = Double(billField.text!) ?? 0
        //Calculate the tip and total
        
        let tipPercentages = [0.1, 0.18, 0.2]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        //Update the tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f",total)
        return bill
    }
    
    @IBAction func settingPressed(_ sender: Any) {
        performSegue(withIdentifier: "HomeToSetting", sender: self)
    }
    
    func didUpdateDefault(_ SettingViewController: SettingViewController, tipDefault: Int) {
        print("Ta", tipDefault)
        tipControl.selectedSegmentIndex = tipDefault
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToSetting" {
            let VC = segue.destination as! SettingViewController
            VC.delegate = self
        }
    }
    
    
    @IBAction func Logout(_ sender: UIBarButtonItem) {
        exit(0)
    }
}

extension MainViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        billField.endEditing(true)
        return true // allows the textField to return
    }

    //Validation when should the text field end editing
    //return true end editing, false not end
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else{
            textField.placeholder = "Type Something"
            return false
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        secondView.alpha = 1
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
//        UIView.animate(withDuration:0.4, animations: {
//            // This causes first view to fade in and second view to fade out
//            self.secondView.alpha = 1
//        })
        let duration: TimeInterval = 0.5
        UIView.animate(withDuration: duration, animations: {
           self.topConstraint.constant = 45
            self.billField.font = UIFont.systemFont(ofSize: 70.0)
            self.secondView.alpha = 1
                  }, completion: nil)
         
    }
}


