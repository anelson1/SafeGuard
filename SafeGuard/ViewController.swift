//
//  ViewController.swift
//  Password Tester
//
//  Created by Student on 4/5/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit
import LocalAuthentication
import iAd


class ViewController: UIViewController, UIAlertViewDelegate, UITextFieldDelegate,ADBannerViewDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var createAPassButton: UIButton!
    @IBOutlet weak var activityIndicatiorView: UIActivityIndicatorView!
    let myDefaults = NSUserDefaults.standardUserDefaults()
    let passwordstorage = "passwordstorage"
    var passwords = password()
    var bannerView: ADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = ADBannerView(adType: .Banner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.delegate = self
        bannerView.hidden = true
        view.addSubview(bannerView)
        
        let viewsDictionary = ["bannerView": bannerView]
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        self.navigationItem.setHidesBackButton(true, animated:true)
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ll")!)
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
            let alert = UIAlertController(title: "Welcome", message: "Welcome to SafeGuard, Please make a password", preferredStyle: .Alert)
            
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
           }
    
    @IBAction func touchIDButton(sender: AnyObject) {
        activityIndicatiorView.startAnimating()

        authenticateUser()
    }
    @IBAction func makePassword(sender: AnyObject) {
        if passwords.password != ""
        {
            makeAlertView("SafeGuard", message: "A password already exists, if you forgot your password, please use the forgot password button", buttonTitle: "Ok")
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
                        self.makeAlertView("SafeGuard", message: "Password was reset. Please make a new one", buttonTitle: "Ok")
                    }
                    else{
                        self.makeAlertView("SafeGuard", message: "Input was incorrect, Please try again", buttonTitle: "OK")
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
            makeAlertView("SafeGuard", message: "Password does not exist, please make one", buttonTitle: "Ok")
        }
    }
    
    @IBAction func continueButton(sender: AnyObject) {
        if passwords.password == textField.text && textField.text != ""
        {
            performSegueWithIdentifier("toMain", sender: nil)
            
        }
        else if passwords.password != textField.text{
            makeAlertView("SafeGuard", message: "Password was incorrect", buttonTitle: "Ok")
        }
        else{
            makeAlertView("SafeGuard", message: "No Password Was Entered, Please Enter A Password", buttonTitle: "Ok")
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
                        self.activityIndicatiorView.stopAnimating()

                        
                    case LAError.UserCancel.rawValue:
                        print("Authentication was cancelled by the user")
                        self.activityIndicatiorView.stopAnimating()

                        
                    case LAError.UserFallback.rawValue:
                        self.activityIndicatiorView.stopAnimating()
                        print("User selected to enter custom password")
                        self.showPasswordAlert()
                        
                    default:
                        print("Authentication failed")
                        self.activityIndicatiorView.stopAnimating()
                        self.showPasswordAlert()
                    }
                }
                
            })]
        }
        else{
            switch error!.code{
                
            case LAError.TouchIDNotEnrolled.rawValue:
                print("TouchID is not enrolled")
                self.activityIndicatiorView.stopAnimating()

            case LAError.PasscodeNotSet.rawValue:
                print("A passcode has not been set")
                self.activityIndicatiorView.stopAnimating()

                
            default:
                print("TouchID not available")
                self.activityIndicatiorView.stopAnimating()

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
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        bannerView.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        bannerView.hidden = true
    }
    }


