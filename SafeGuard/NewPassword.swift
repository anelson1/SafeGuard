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
        let alertAction = UIAlertAction(title: "Favorite Pets Name?", style: .Default) { (ACTION) in
            self.question.text = "Favorite Pets Name?"
        }
        let alertAction1 = UIAlertAction(title: "Mothers Maiden Name?", style: .Default) { (ACTION) in
            self.question.text = "Mothers Maiden Name?"
        }
        let alertAction2 = UIAlertAction(title: "Street You Grew Up On?", style: .Default) { (ACTION) in
            self.question.text = "Street You Grew Up On?"
        }

        let alertAction3 = UIAlertAction(title: "Favorite Teacher?", style: .Default) { (ACTION) in
            self.question.text = "Favorite Teacher"
        }

        let alertAction4 = UIAlertAction(title: "Favorite Fictional Character", style: .Default) { (ACTION) in
            self.question.text = "Favorite Fictional Character"
        }



              alert.addAction(alertAction)
        alert.addAction(alertAction1)
        alert.addAction(alertAction2)
        alert.addAction(alertAction3)
        alert.addAction(alertAction4)
        presentViewController(alert, animated: true, completion: nil)
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
      let alertAction = UIAlertAction(title: title, style: .Default) { (ACTION) in
        self.question.text = title
        }
    }
    
    
}
