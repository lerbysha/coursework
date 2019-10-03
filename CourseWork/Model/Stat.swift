//
//  Stat.swift
//  CourseWork
//
//  Created by Артур Гайсин on 02/10/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import Foundation
import RealmSwift

class Stat: Object {
   // @objc dynamic var id = 0
    @objc dynamic var key = ""
    @objc dynamic var like = false
    @objc dynamic var value = ""
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}
