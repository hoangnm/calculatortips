//
//  SettingsTableViewController.swift
//  tips
//
//  Created by VietCas on 2/24/16.
//  Copyright © 2016 VietCas. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UITextFieldDelegate {
    // MARK: - Properties
    @IBOutlet weak var darkThemeSwitch: UISwitch!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let isDarkTheme = defaults.boolForKey("is_dark_theme")
        
        if isDarkTheme {
            darkThemeSwitch.setOn(true, animated: false)
        } else {
            darkThemeSwitch.setOn(false, animated: false)
        }
        
        let tipIndex = defaults.integerForKey("tip_segment_index")
        tipControl.selectedSegmentIndex = tipIndex
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let isDarkTheme = darkThemeSwitch.on
        defaults.setBool(isDarkTheme, forKey: "is_dark_theme")
    
        let tipSegmentIndex = tipControl.selectedSegmentIndex
        defaults.setInteger(tipSegmentIndex, forKey: "tip_segment_index")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITextFieldDelegate
        
    // MARK: - Action
    @IBAction func onDarkThemChange(sender: UISwitch) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
