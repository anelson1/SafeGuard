//
//  NewPassword.swift
//  Password Tester
//
//  Created by hspitzer on 4/7/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit
import iAd

class NewPassword: UIViewController, UITextFieldDelegate,ADBannerViewDelegate {
    
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var enterTextField: UITextField!
    var passwords = password()
    let myDefaults = UserDefaults.standard
    var bannerView : ADBannerView!
    override func viewDidLoad() {
        bannerView = ADBannerView(adType: .banner)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerView.delegate = self
        bannerView.isHidden = true
        view.addSubview(bannerView)
        
        let viewsDictionary = ["bannerView": bannerView]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bannerView]|", options: [], metrics: nil, views: viewsDictionary))
        super.viewDidLoad()
        confirmTextField.delegate = self
        enterTextField.delegate = self
        questionField.delegate = self
    }
    
    @IBAction func onScreenTapped(_ sender: AnyObject) {
        enterTextField.resignFirstResponder()
        confirmTextField.resignFirstResponder()
        questionField.resignFirstResponder()
    }
    
    @IBAction func pickQuestion(_ sender: AnyObject) {
        let alert = UIAlertController(title: "Select question", message: nil, preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "Favorite Pets Name?", style: .default) { (ACTION) in
            self.question.text = "Favorite Pets Name?"
            self.passwords.question = "Favorite Pets Name?"
        }
        let alertAction1 = UIAlertAction(title: "Mothers Maiden Name?", style: .default) { (ACTION) in
            self.question.text = "Mothers Maiden Name?"
            self.passwords.question = "Mothers Maiden Name?"
        }
        let alertAction2 = UIAlertAction(title: "Street You Grew Up On?", style: .default) { (ACTION) in
            self.question.text = "Street You Grew Up On?"
            self.passwords.question = "Street You Grew Up On?"
            
        }
        
        let alertAction3 = UIAlertAction(title: "Favorite Teacher?", style: .default) { (ACTION) in
            self.question.text = "Favorite Teacher"
            self.passwords.question = "Favorite Teacher?"
            
        }
        
        let alertAction4 = UIAlertAction(title: "Favorite Fictional Character?", style: .default) { (ACTION) in
            self.question.text = "Favorite Fictional Character?"
            self.passwords.question = "Favorite Fictional Character?"
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        
        alert.addAction(alertAction)
        alert.addAction(alertAction1)
        alert.addAction(alertAction2)
        alert.addAction(alertAction3)
        alert.addAction(alertAction4)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func makePassword(_ sender: AnyObject) {
        if enterTextField.text == confirmTextField.text && questionField.text != "" && passwords.question != ""
        {
            passwords.password = enterTextField.text!
            passwords.questionAnswer = questionField.text!
            myDefaults.set(questionField.text, forKey: "questionAnswer")
            myDefaults.set(enterTextField.text, forKey: "passwordstorage")
            myDefaults.set(passwords.question, forKey: "question")
            let alert = UIAlertController(title: "Password Confirm", message: "Your password has been saved", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertaction)
            present(alert, animated: true, completion: nil)
            
            
        }
        else if questionField.text == ""
        {
            let alert = UIAlertController(title: "Password Confirm", message: "You did not fill in a secret question", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertaction)
            present(alert, animated: true, completion: nil)
        }
        else if passwords.question == ""
        {
            let alert = UIAlertController(title: "Password Confirm", message: "You did not pick a secret question", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertaction)
            present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Password", message: "Your passwords did not match", preferredStyle: .alert)
            let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertaction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func onDoneTapped(_ sender: AnyObject) {
        dismiss(animated: true) { 
             func prepareForSegue(_ segue: UIStoryboardSegue, sender: AnyObject?) {
                let dvc = segue.destination as! ViewController
                dvc.passwords = self.passwords.self
                
                
                
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
