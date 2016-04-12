//
//  ViewController.swift
//  Password Tester
//
//  Created by Student on 4/5/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit
import LocalAuthentication


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
    @IBAction func resetPasswordAdmin(sender: AnyObject) {
        passwords.password = ""
    print("Test")
    }
    
    @IBAction func touchIDButton(sender: AnyObject) {
        authenticateUser()
    }
    @IBAction func makePassword(sender: AnyObject) {
        if passwords.password != ""
        {
            makeAlertView("Password", message: "A password already exists, if you forgot your password, please use the forgot password button", buttonTitle: "Ok")
        }
        else
        {
     performSegueWithIdentifier("toMakePassword", sender: nil)        }
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
    func authenticateUser() {
        // Get the local authentication context.
        let context = LAContext()
        
        // Declare a NSError variable.
        var error: NSError?
        
        // Set the reason string that will appear on the authentication alert.
        var reasonString = "Authentication is needed to access your notes."
        
        // Check if the device can evaluate the policy.
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            [context .evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in
                
                if success {
                    self.performSegueWithIdentifier("SpicyMeme", sender: nil)
                    
                }
                else{
                    // If authentication failed then show a message to the console with a short description.
                    // In case that the error is a user fallback, then show the password alert view.
                    print(evalPolicyError?.localizedDescription)
                    
                    switch evalPolicyError!.code {
                        
                    case LAError.SystemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        
                    case LAError.UserCancel.rawValue:
                        print("Authentication was cancelled by the user")
                        
                    case LAError.UserFallback.rawValue:
                        print("User selected to enter custom password")
                        self.showPasswordAlert()
                        
                    default:
                        print("Authentication failed")
                        self.showPasswordAlert()
                    }
                }
                
            })]
        }
        else{
            switch error!.code{
                
            case LAError.TouchIDNotEnrolled.rawValue:
                print("TouchID is not enrolled")
                
            case LAError.PasscodeNotSet.rawValue:
                print("A passcode has not been set")
                
            default:
                print("TouchID not available")
            }
            
            print(error?.localizedDescription)
            
            self.showPasswordAlert()
        }
    }
    func showPasswordAlert() {
        var passwordAlert : UIAlertView = UIAlertView(title: "SafeGuard", message: "Please type your password", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Okay")
        passwordAlert.alertViewStyle = UIAlertViewStyle.SecureTextInput
        passwordAlert.show()
    }
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            if !alertView.textFieldAtIndex(0)!.text!.isEmpty {
                if alertView.textFieldAtIndex(0)!.text == passwords.password {
                    performSegueWithIdentifier("SpicyMeme", sender: nil)
                    
                }
                else{
                    showPasswordAlert()
                }
            }
            else{
                showPasswordAlert()
            }
        }
    }
}


