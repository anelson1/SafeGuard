//
//  ViewController.swift
//  Password Tester
//
//  Created by Student on 4/5/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIAlertViewDelegate {
    @IBOutlet weak var textField: UITextField!
    let myDefaults = NSUserDefaults.standardUserDefaults()
    let passwordstorage = "passwordstorage"
    var passwords = password()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let password1 = myDefaults.objectForKey("passwordstorage")
        {
            passwords.password = String(password1)
        }
    }
    
    
    @IBAction func resetPassword(sender: AnyObject) {
        let alertController = UIAlertController(title: "Password?", message: "Please input your Password:", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .Default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                if field.text == self.passwords.password
                {
                    self.passwords.password = ""
                    self.makeAlertView("Password", message: "Password was reset. Please make a new one", buttonTitle: "Ok")
                }
                else{
                    self.makeAlertView("Password", message: "Password was incorrect, Please try again", buttonTitle: "OK")
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Password"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)

    }
    
    @IBAction func continueButton(sender: AnyObject) {
        if passwords.password == textField.text
        {
            performSegueWithIdentifier("SpicyMeme", sender: nil)
            
        }
        else{
            makeAlertView("Password", message: "Password was incorrect", buttonTitle: "Ok")
        }
        

    }
    func makeAlertView(title: String, message: String, buttonTitle: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let alertaction = UIAlertAction(title: buttonTitle, style: .Default, handler: nil)
        alert.addAction(alertaction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
}


