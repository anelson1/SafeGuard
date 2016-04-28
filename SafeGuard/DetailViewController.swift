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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ll")!)

        passwordTitle.text = data.title
        passwordTextField.text = data.password
}
    @IBAction func saveButton(sender: AnyObject) {
        passwords.password = passwordTextField.text
        data.password = passwordTextField.text
        
        
    }
}
