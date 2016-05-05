//
//  NoteTableViewCell.swift
//  SafeGuard
//
//  Created by Student on 5/5/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit


class NoteTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    static var dateFormatter: NSDateFormatter = {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter
    }()
    
    
    var note: Note? {
        didSet {
            if let note = note, titleLabel = titleLabel, dateLabel = dateLabel {
                titleLabel.text = note.title
                dateLabel.text = NoteTableViewCell.dateFormatter.stringFromDate(note.modificationDate)
            }
        }
    }
    
}