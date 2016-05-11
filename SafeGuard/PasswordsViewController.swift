//
//  ViewController.swift
//  Collage Profile Builder
//
//  Created by Student on 1/20/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//


import UIKit
import Foundation
import Realm
import RealmSwift
class PasswordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var passwordTitleLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    dynamic var data : [ClassOfData] = []
    var dataArray = [String]()
    let savedCell = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController!.navigationBar.barTintColor = UIColor.grayColor()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ll")!)
        
        if let cell = savedCell.valueForKey("SavedCells"){
            if let passsword = savedCell.valueForKey("Password"){
            data.append(ClassOfData(title: String(cell), password: String(passsword)))

        }
        }
               print(data.count)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        cell.textLabel?.text = data[indexPath.row].title
        return cell
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            data.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func onPlusTapped(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Password", message: nil, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Add Password Title Here"
        }
        alert.addTextFieldWithConfigurationHandler { (textField2) -> Void in
            textField2.placeholder = "Add Password Here"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alert.addAction(cancelAction)
        let addAction = UIAlertAction(title: "Add", style: .Default) { (action) -> Void in
            let passwordTextField = alert.textFields![0] as UITextField
            let otherPasswordTextField = alert.textFields![1] as UITextField
           
            self.data.append(ClassOfData(title: passwordTextField.text!, password: otherPasswordTextField.text!))
            self.dataArray.append(passwordTextField.text!)
            self.savedCell.setValue(passwordTextField.text, forKey: "SavedCells")
            self.savedCell.setValue(otherPasswordTextField.text, forKey: "Password")
            self.savedCell.synchronize()
            
            self.tableView.reloadData()
        }
        alert.addAction(addAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let collage = data[sourceIndexPath.row]
        data.removeAtIndex(sourceIndexPath.row)
        data.insert(collage, atIndex: destinationIndexPath.row)
    }
    
    @IBAction func onEditTapped(sender: UIBarButtonItem) {
        if sender.tag == 0 {
            tableView.editing = true
            sender.tag = 1
        }
        else {
            tableView.editing = false
            sender.tag = 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! DetailViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.data = data[index!]
        
        
        
    }
}
