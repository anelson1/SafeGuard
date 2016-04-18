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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ll")!)
    

        
    }
    
    @IBAction func pickQuestion(sender: AnyObject) {
        let alert = UIAlertController(title: "Select question", message: nil, preferredStyle: .ActionSheet)
        let alertAction = UIAlertAction(title: "Favorite Pets Name?", style: .Default) { (ACTION) in
            self.question.text = "Favorite Pets Name?"
            self.passwords.question = "Favorite Pets Name?"
        }
        let alertAction1 = UIAlertAction(title: "Mothers Maiden Name?", style: .Default) { (ACTION) in
            self.question.text = "Mothers Maiden Name?"
            self.passwords.question = "Mothers Maiden Name?"
        }
        let alertAction2 = UIAlertAction(title: "Street You Grew Up On?", style: .Default) { (ACTION) in
            self.question.text = "Street You Grew Up On?"
            self.passwords.question = "Street You Grew Up On?"

        }

        let alertAction3 = UIAlertAction(title: "Favorite Teacher?", style: .Default) { (ACTION) in
            self.question.text = "Favorite Teacher"
            self.passwords.question = "Favorite Teacher?"

        }

        let alertAction4 = UIAlertAction(title: "Favorite Fictional Character?", style: .Default) { (ACTION) in
            self.question.text = "Favorite Fictional Character?"
            self.passwords.question = "Favorite Fictional Character?"

        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)



              alert.addAction(alertAction)
        alert.addAction(alertAction1)
        alert.addAction(alertAction2)
        alert.addAction(alertAction3)
        alert.addAction(alertAction4)
        alert.addAction(cancel)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func makePassword(sender: AnyObject) {
        if enterTextField.text == confirmTextField.text && questionField.text != "" && passwords.question != ""
        {
            passwords.password = enterTextField.text!
            passwords.questionAnswer = questionField.text!
            myDefaults.setObject(questionField.text, forKey: "questionAnswer")
            myDefaults.setObject(enterTextField.text, forKey: "passwordstorage")
            myDefaults.setObject(passwords.question, forKey: "question")
            let alert = UIAlertController(title: "Password Confirm", message: "Your password has been saved", preferredStyle: .Alert)
            let alertaction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(alertaction)
            presentViewController(alert, animated: true, completion: nil)
            
        }
        else if questionField.text == ""
        {
            let alert = UIAlertController(title: "Password Confirm", message: "You did not fill in a secret question", preferredStyle: .Alert)
            let alertaction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(alertaction)
            presentViewController(alert, animated: true, completion: nil)
        }
            else if passwords.question == ""
        {
            let alert = UIAlertController(title: "Password Confirm", message: "You did not pick a secret question", preferredStyle: .Alert)
            let alertaction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alert.addAction(alertaction)
            presentViewController(alert, animated: true, completion: nil)
        }
        else{
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

    
}
