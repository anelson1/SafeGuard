//
//  NewPassword.swift
//  Password Tester
//
//  Created by hspitzer on 4/7/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit

class NewPassword: UIViewController {
    
    @IBOutlet weak var enterTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    var passwords = password()
    let myDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func savePassword(sender: AnyObject) {
        if enterTextField.text == confirmTextField.text
        {
            passwords.password = enterTextField.text!
            myDefaults.setObject(enterTextField.text, forKey: "Dank")
            let alert = UIAlertController(title: "Password Confirm", message: "Your password has been saved", preferredStyle: .Alert)
            let alertaction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(alertaction)
            presentViewController(alert, animated: true, completion: nil)
            
        }
        else
        {
            let alert = UIAlertController(title: "Password Confirm", message: "Your passwords did not match", preferredStyle: .Alert)
            let alertaction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(alertaction)
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
}
