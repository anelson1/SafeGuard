//
//  NewNoteViewController.swift
//  SafeGuard
//
//  Created by Student on 5/6/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit

class NewNoteViewController: UIViewController {
    var meme: passwordClassword?

   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "ShowNewNote") {
            meme = passwordClassword()
            let dvc = segue.destinationViewController as! NoteDisplayViewController
            dvc.meme = meme
        }
    }
    }
