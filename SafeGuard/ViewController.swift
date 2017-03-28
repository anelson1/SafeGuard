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
    let myDefaults = UserDefaults.standard
    let passwordstorage = "passwordstorage"
    var passwords = password()
    var bannerView: ADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bannerView = ADBannerView(adType: .banner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.delegate = self
        bannerView.isHidden = true
        view.addSubview(bannerView)
        
        let viewsDictionary = ["bannerView": bannerView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        self.navigationItem.setHidesBackButton(true, animated:true)
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ll")!)
        textField.delegate = self
        forgotPassButton.setTitle("Forgot Password?", for: UIControlState())
        forgotPassButton.titleLabel?.numberOfLines = 0
        if let password1 = myDefaults.object(forKey: "passwordstorage")
        {
            passwords.password = String(describing: password1)
        }
        if let question = myDefaults.object(forKey: "question")
        {
            passwords.question = String(describing: question)
        }
        if let questionAnswer = myDefaults.object(forKey: "questionAnswer")
        {
            passwords.questionAnswer = String(describing: questionAnswer)
        }
        if passwords.password == ""
        {
            let alert = UIAlertController(title: "Welcome", message: "Welcome to SafeGuard, Please make a password", preferredStyle: .alert)
            
            let alertaction = UIAlertAction(title: "Ok", style: .default, handler: { (ACTION) in
                self.performSegue(withIdentifier: "toMakePassword", sender: nil)
            })
            alert.addAction(alertaction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
        textField.resignFirstResponder()

        if passwords.password == textField.text
        {
            performSegue(withIdentifier: "toMain", sender: nil)
            
        }
        else{
            makeAlertView("Password", message: "Password was incorrect", buttonTitle: "Ok")
        }
        return true
    }
    
    
    @IBAction func resetPasswordAdmin(_ sender: AnyObject) {
           }
    
    @IBAction func touchIDButton(_ sender: AnyObject) {
        activityIndicatiorView.startAnimating()

        authenticateUser()
    }
    @IBAction func makePassword(_ sender: AnyObject) {
        if passwords.password != ""
        {
            makeAlertView("SafeGuard", message: "A password already exists, if you forgot your password, please use the forgot password button", buttonTitle: "Ok")
        }
        else
        {
            performSegue(withIdentifier: "toMakePassword", sender: nil)        }
    }
    
    @IBAction func resetPassword(_ sender: AnyObject) {
        if passwords.password != ""
        {
            let alertController = UIAlertController(title: "Reset Password", message: passwords.question, preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
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
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
            
            alertController.addTextField { (textField) in
                textField.placeholder = "Password"
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            makeAlertView("SafeGuard", message: "Password does not exist, please make one", buttonTitle: "Ok")
        }
    }
    
    @IBAction func continueButton(_ sender: AnyObject) {
        if passwords.password == textField.text && textField.text != ""
        {
            performSegue(withIdentifier: "toMain", sender: nil)
            
        }
        else if passwords.password != textField.text{
            makeAlertView("SafeGuard", message: "Password was incorrect", buttonTitle: "Ok")
        }
        else{
            makeAlertView("SafeGuard", message: "No Password Was Entered, Please Enter A Password", buttonTitle: "Ok")
        }
        
        
    }
    @IBAction func onScreenTapped(_ sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func makeAlertView(_ title: String, message: String, buttonTitle: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertaction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(alertaction)
        present(alert, animated: true, completion: nil)
    }
    func authenticateUser() {
        let context = LAContext()
        var error: NSError?
        let reasonString = "Authentication is needed to access your files."
        
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            [context .evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success: Bool, evalPolicyError: NSError?) -> Void in

                if success {
                    self.performSegue(withIdentifier: "toMain", sender: nil)
                    
                }
                else{
                    self.activityIndicatiorView.stopAnimating()
                    print(evalPolicyError?.localizedDescription)
                    
                    switch evalPolicyError!.code {
                        
                    case LAError.Code.systemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        self.activityIndicatiorView.stopAnimating()

                        
                    case LAError.Code.userCancel.rawValue:
                        print("Authentication was cancelled by the user")
                        self.activityIndicatiorView.stopAnimating()

                        
                    case LAError.Code.userFallback.rawValue:
                        self.activityIndicatiorView.stopAnimating()
                        print("User selected to enter custom password")
                        self.showPasswordAlert()
                        
                    default:
                        print("Authentication failed")
                        self.activityIndicatiorView.stopAnimating()
                        self.showPasswordAlert()
                    }
                }
                
            } as! (Bool, Error?) -> Void)]
        }
        else{
            switch error!.code{
                
            case LAError.Code.touchIDNotEnrolled.rawValue:
                print("TouchID is not enrolled")
                self.activityIndicatiorView.stopAnimating()

            case LAError.Code.passcodeNotSet.rawValue:
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
        let passwordAlert : UIAlertView = UIAlertView(title: "SafeGuard", message: "Device is not Touch ID enrolled, Please enter password", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Okay")
        passwordAlert.alertViewStyle = UIAlertViewStyle.secureTextInput
        passwordAlert.show()
    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if buttonIndex == 1 {
            if !alertView.textField(at: 0)!.text!.isEmpty {
                if alertView.textField(at: 0)!.text == passwords.password {
                    performSegue(withIdentifier: "toMakePassword", sender: nil)
                    
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
    func bannerViewDidLoadAd(_ banner: ADBannerView!) {
        bannerView.isHidden = false
    }
    
    func bannerView(_ banner: ADBannerView!, didFailToReceiveAdWithError error: Error!) {
        bannerView.isHidden = true
    }
    }


