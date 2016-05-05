//
//  Note.swift
//  SafeGuard
//
//  Created by Student on 5/5/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var modificationDate = NSDate()
}
