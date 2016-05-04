//
//  ViewController.swift
//  Password Tester
//
//  Created by Student on 4/5/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit
import LocalAuthentication


class ViewController: UIViewController, UIAlertViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var createAPassButton: UIButton!
    @IBOutlet weak var activityIndicatiorView: UIActivityIndicatorView!
    let myDefaults = NSUserDefaults.standardUserDefaults()
    let passwordstorage = "passwordstorage"
    var passwords = password()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        navigationController!.navigationBar.barTintColor = UIColor.grayColor()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ll")!)
        textField.delegate = self
        forgotPassButton.setTitle("Forgot Password?", forState: UIControlState.Normal)
        forgotPassButton.titleLabel?.numberOfLines = 0
        if let password1 = myDefaults.objectForKey("passwordstorage")
        {
            passwords.password = String(password1)
        }
        if let question = myDefaults.objectForKey("question")
        {
            passwords.question = String(question)
        }
        if let questionAnswer = myDefaults.objectForKey("questionAnswer")
        {
            passwords.questionAnswer = String(questionAnswer)
        }
        if passwords.password == ""
        {
            let alert = UIAlertController(title: "Welcome", message: "Welcome to safeguard, Please make a password", preferredStyle: .Alert)
            
            let alertaction = UIAlertAction(title: "Ok", style: .Default, handler: { (ACTION) in
                self.performSegueWithIdentifier("toMakePassword", sender: nil)
            })
            alert.addAction(alertaction)
            presentViewController(alert, animated: true, completion: nil)
        }
        
    }
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()

        if passwords.password == textField.text
        {
            performSegueWithIdentifier("toMain", sender: nil)
            
        }
        else{
            makeAlertView("Password", message: "Password was incorrect", buttonTitle: "Ok")
        }
        return true
    }
    
    
    @IBAction func resetPasswordAdmin(sender: AnyObject) {
        passwords.password = ""
        passwords.question = ""
        passwords.questionAnswer = ""
        print("Test")
    }
    
    @IBAction func touchIDButton(sender: AnyObject) {
        activityIndicatiorView.startAnimating()

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
        if passwords.password != ""
        {
            let alertController = UIAlertController(title: "Reset Password", message: passwords.question, preferredStyle: .Alert)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .Default) { (_) in
                if let field = alertController.textFields![0] as? UITextField {
                    if field.text == self.passwords.questionAnswer
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
        else{
            makeAlertView("Password", message: "Password does not exist, please make one", buttonTitle: "Ok")
        }
    }
    
    @IBAction func continueButton(sender: AnyObject) {
        if passwords.password == textField.text && textField.text != ""
        {
            performSegueWithIdentifier("toMain", sender: nil)
            
        }
        else if passwords.password != textField.text{
            makeAlertView("Password", message: "Password was incorrect", buttonTitle: "Ok")
        }
        else{
            makeAlertView("Password", message: "No Password Was Entered, Please Enter A Password", buttonTitle: "Ok")
        }
        
        
    }
    @IBAction func onScreenTapped(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func makeAlertView(title: String, message: String, buttonTitle: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let alertaction = UIAlertAction(title: buttonTitle, style: .Default, handler: nil)
        alert.addAction(alertaction)
        presentViewController(alert, animated: true, completion: nil)
    }
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        var reasonString = "Authentication is needed to access your files."
        
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error) {
            [context .evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in

                if success {
                    self.performSegueWithIdentifier("toMain", sender: nil)
                    
                }
                else{
                    self.activityIndicatiorView.stopAnimating()
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
            self.showPasswordAlert()
        }
    }
    func showPasswordAlert() {
        var passwordAlert : UIAlertView = UIAlertView(title: "SafeGuard", message: "Device is not Touch ID enrolled, Please enter password", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Okay")
        passwordAlert.alertViewStyle = UIAlertViewStyle.SecureTextInput
        passwordAlert.show()
    }
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            if !alertView.textFieldAtIndex(0)!.text!.isEmpty {
                if alertView.textFieldAtIndex(0)!.text == passwords.password {
                    performSegueWithIdentifier("toMakePassword", sender: nil)
                    
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


