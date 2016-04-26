//
//  Collages.swift
//  Collage Profile Builder
//
//  Created by Student on 1/25/16.
//  Copyright © 2016 Dank Memes and Son International Shipping Company Express. All rights reserved.
//

import UIKit

class ClassOfData: NSObject {
    var title = ""
    var password = ""
    var numberOfStudents = 0
    
    convenience init(title: String, password: String) {
        self.init()
        self.title = title
        self.password = password
    }
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}
