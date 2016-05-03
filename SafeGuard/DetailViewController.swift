//
//  DetailViewController.swift
//  SafeGuard
//
//  Created by Student on 4/28/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController {

    @IBOutlet weak var passwordTitle: UILabel!
    @IBOutlet weak var passwordTextBox: UITextField!
    @IBOutlet weak var passwordTextField: UITextView!
    var data = ClassOfData()
    var passwords = password()
    var dataArray = [String]()
    let savedPassword = NSUserDefaults.standardUserDefaults()
    var passwordArray = []
   
        override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ll")!)
            
            if var anothersavedPassword = savedPassword.stringForKey("RealPassword"){
anothersavedPassword = data.password            }
        passwordTextField.text = data.password
            passwordTitle.text = data.title
            
    }
    @IBAction func saveButton(sender: AnyObject) {
        data.password = passwordTextField.text
        savedPassword.setValue(data.password, forKey: "RealPassword")
        savedPassword.synchronize()

        
        
    
    }
    
}

