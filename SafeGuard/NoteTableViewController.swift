//
//  NoteTableViewController.swift
//  SafeGuard
//
//  Created by Student on 5/5/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
class NoteTableViewController: UITableViewController {
    var notes: Results<Note>! {
        didSet {
            // Whenever notes update, update the table view
            tableView?.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let myNote = Note()
        myNote.title   = "Super Simple Test Note"
        myNote.content = "Spicy Mem"
        
        do {
            let realm = try Realm()
            try realm.write() {
                realm.add(myNote)
            }
            notes = realm.objects(Note)
        }
        catch
        {
            print("handle error")
        }
    }
}
extension NoteTableViewController {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! NoteTableViewCell
        let row = indexPath.row
        let note = notes[row] as Note
        cell.note = note
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
}