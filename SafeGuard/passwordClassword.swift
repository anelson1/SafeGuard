//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by Martin Walsh on 29/05/2015.
//  Updated by Chris Orcutt on 09/07/2015.
//  Copyright © 2015 MakeSchool. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class passwordClassword: Object {
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var modificationDate = Date()
}
