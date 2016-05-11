//
//  PassTableViewController.swift
//  SafeGuard
//
//  Created by Student on 5/6/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit
import RealmSwift
import Foundation

class PassTableViewController: UITableViewController {
    var passwords: Results<passwordClassword>! {
        didSet {
            // Whenever notes update, update the table view
            tableView?.reloadData()
        }
    }
    var meme: passwordClassword?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        do {
            let realm = try Realm()
            passwords = realm.objects(passwordClassword).sorted("modificationDate", ascending: false)
        } catch {
            print("handle error")
        }
    }
    @IBAction func unwindToSegue(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            print("Identifier \(identifier)")
        }
        
        if let identifier = segue.identifier {
            do {
                let realm = try Realm()
                
                switch identifier {
                case "Save":
                    // 1
                    let source = segue.sourceViewController as! NewNoteViewController
                    try realm.write() {
                        realm.add(source.meme!)
                    }
                    
                case "Delete":
                   try realm.write() {
                        realm.delete(self.passwords!)
                    }
                    
                    let source = segue.sourceViewController as! NoteDisplayViewController
                    source.meme = nil;
                default:
                print("No one loves \(identifier)")
                }
                
                passwords = realm.objects(passwordClassword).sorted("modificationDate", ascending: false)
            } catch {
                print("handle error")
            }
        }    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowExistingNote") {
            let dvc = segue.destinationViewController as! NoteDisplayViewController
            dvc.meme = self.meme
        }
    }
}
extension PassTableViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PassCell", forIndexPath: indexPath) as! PassTableViewCell //1
        let row = indexPath.row
        let passs = passwords[row] as passwordClassword
        cell.meme = passs

        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passwords?.count ?? 0
    }
        // 3
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // 4
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let note = passwords[indexPath.row] as Object
            
            do {
                let realm = try Realm()
                try realm.write() {
                    realm.delete(note)
                }
                
                passwords = realm.objects(passwordClassword).sorted("modificationDate", ascending: false)
            } catch {
                print("handle error")
            }
        }
    }
    
}
    
