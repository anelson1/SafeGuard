//
//  NewPassword.swift
//  Password Tester
//
//  Created by hspitzer on 4/7/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit

class NewPassword: UIViewController {
    
   
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var enterTextField: UITextField!
    var passwords = password()
    let myDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "l")!)

        
    }
    
    @IBAction func pickQuestion(sender: AnyObject) {
        let alert = UIAlertController(title: "Select question", message: nil, preferredStyle: .ActionSheet)
        addActionSheetOption("Favorite Pets Name?")
    }
    
    @IBAction func makePassword(sender: AnyObject) {
        if enterTextField.text == confirmTextField.text
        {
            passwords.password = enterTextField.text!
            myDefaults.setObject(enterTextField.text, forKey: "passwordstorage")
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! ViewController
        
        dvc.passwords = self.passwords
        
    }
    func addActionSheetOption(title: String)
    {
      let alert = UIAlertAction(title: title, style: .Default, handler: nil)
    }
    
    
}
