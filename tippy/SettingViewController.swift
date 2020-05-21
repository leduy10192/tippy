//
//  SettingViewController.swift
//  tippy
//
//  Created by Duy Le on 5/9/20.
//  Copyright © 2020 Duy Le. All rights reserved.
//

import UIKit

protocol SettingsDelegate {
    func didUpdateDefault(_ SettingViewController: SettingViewController, tipDefault: Int)
}
    
class SettingViewController: UIViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    let defaults = UserDefaults.standard
    
    var delegate : SettingsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tipDefault = tipControl.selectedSegmentIndex
        delegate?.didUpdateDefault(self, tipDefault: tipDefault)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tipControlPressed(_ sender: Any) {
        let tipDefault = tipControl.selectedSegmentIndex
        defaults.set(tipDefault, forKey: "tipDefault")
        delegate?.didUpdateDefault(self, tipDefault: tipDefault)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
