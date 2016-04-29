//
//  DetailViewController.swift
//  SafeGuard
//
//  Created by Student on 4/28/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit
import RealmSwift
class DetailViewController: UIViewController {

    @IBOutlet weak var passwordTitle: UILabel!
    @IBOutlet weak var passwordTextBox: UITextField!
    @IBOutlet weak var passwordTextField: UITextView!
    var data = ClassOfData()
    var passwords = password()
    let realm = try! Realm()
    var passwordArray = []
override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ll")!)
    let savedPassword = realm.objects(ClassOfData)
    dispatch_async(dispatch_queue_create("background", nil)) {
        let realm = try! Realm()
        var thePassword = realm.objects(ClassOfData)
        try! realm.write {
            
        }
    }

    }
    @IBAction func saveButton(sender: AnyObject) {
        data.password = passwordTextField.text
        try! realm.write {
            realm.add(data)
        }
        
    
    }
    
}
