//
//  Contact.swift
//  Messenger
//
//  Created by Mohammad Allam on 6/30/18.
//  Copyright © 2018 Allam. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class Contact: Object {

    let id = RealmOptional<Int>()
    dynamic var name = ""
    let numbers = List<String>()

    convenience init(name: String) {
        self.init()
        self.name = name
    }

    convenience init(name: String, id: Int) {
        self.init(name: name)
        self.id.value = id
    }

    convenience init(name: String, numbers: List<String>) {
        self.init(name: name)
        self.numbers.append(objectsIn: numbers)
    }

    convenience init(id: Int, name: String, numbers: List<String>) {
        self.init(name: name)
        self.numbers.append(objectsIn: numbers)
        self.id.value = id
    }
}
