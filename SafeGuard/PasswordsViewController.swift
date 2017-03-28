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
    let savedCell = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController!.navigationBar.barTintColor = UIColor.grayColor()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ll")!)
        
        if let cell = savedCell.value(forKey: "SavedCells"){
            if let passsword = savedCell.value(forKey: "Password"){
            data.append(ClassOfData(title: String(describing: cell), password: String(describing: passsword)))

        }
        }
               print(data.count)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func onPlusTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Password", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) -> Void in
            textField.placeholder = "Add Password Title Here"
        }
        alert.addTextField { (textField2) -> Void in
            textField2.placeholder = "Add Password Here"
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) -> Void in
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
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let collage = data[sourceIndexPath.row]
        data.remove(at: sourceIndexPath.row)
        data.insert(collage, at: destinationIndexPath.row)
    }
    
    @IBAction func onEditTapped(_ sender: UIBarButtonItem) {
        if sender.tag == 0 {
            tableView.isEditing = true
            sender.tag = 1
        }
        else {
            tableView.isEditing = false
            sender.tag = 0
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! DetailViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.data = data[index!]
        
        
        
    }
}
