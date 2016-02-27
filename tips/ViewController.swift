//
//  ViewController.swift
//  tips
//
//  Created by VietCas on 2/21/16.
//  Copyright © 2016 VietCas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    
    var tipPercentage = 0.18
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        billTextField.textColor = UIColor.whiteColor()
        billTextField.delegate = self
        let defaults = NSUserDefaults.standardUserDefaults()
        if let lastDateActiveObj = defaults.objectForKey("last_date_active") {
            let billValue = defaults.objectForKey("bill_value") as! String
            let lastDateActive = lastDateActiveObj as! NSDate
            let date = NSDate()
            if date.timeIntervalSinceDate(lastDateActive) < 60 {
                billTextField.text = billValue
            }
        }
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "applicationWillResignActive", name: UIApplicationWillResignActiveNotification, object: nil)
    }
    
     //MARK: - Observe Notification Application State
    
    func applicationWillResignActive() {
        let defaults = NSUserDefaults.standardUserDefaults()
        let date = NSDate()
        defaults.setValue(date, forKey: "last_date_active")
        if let billText = billTextField.text {
            defaults.setValue(billText, forKey: "bill_value")
        }
        defaults.synchronize()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let isDarkTheme = defaults.boolForKey("is_dark_theme")
        
        if isDarkTheme {
            view.backgroundColor = UIColor.darkGrayColor()
            resultView.backgroundColor = UIColor.blueColor()
        } else {
            view.backgroundColor = UIColor.lightGrayColor()
            resultView.backgroundColor = UIColor.orangeColor()
        }
        
        let tips = [0.18, 0.2, 0.25]
        let tipIndex = defaults.integerForKey("tip_segment_index")
        tipPercentage = tips[tipIndex]
        
        billTextField.becomeFirstResponder()
        
        updateTip()
        
        showViewOrInputOnly()
    }
    
    //MARK: - Handle ViewInput
    func showInputViewOnly() {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.updateChildFramePosition(350, billsFrameY: 190)
        }
    }
    
    func showResultView() {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.updateChildFramePosition(200, billsFrameY: 100)
        }
    }
    
    func updateChildFramePosition(resultsFrameY: CGFloat, billsFrameY: CGFloat) {
        var resultFrame = self.resultView.frame
        resultFrame.origin.y = resultsFrameY
        self.resultView.frame = resultFrame
        
        var billFrame = self.billTextField.frame
        billFrame.origin.y = billsFrameY
        self.billTextField.frame = billFrame
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTip() {
        let billAmount = NSString(string: billTextField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        tipPercentLabel.text = String(format: "%.f%%", tipPercentage * 100)
    }
    
    func showViewOrInputOnly() {
        if billTextField.text != nil {
            if(billTextField.text!.isEmpty) {
                showInputViewOnly()
            } else {
                showResultView()
                updateTip()
            }
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(!string.isEmpty) {
            let number = Int(string)
            if  number == nil {
                return false
            }
        }
        return true;
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        showViewOrInputOnly()
    }

    @IBAction func onTap(sender: AnyObject) {

    }
}

