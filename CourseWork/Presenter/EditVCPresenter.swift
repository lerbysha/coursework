//
//  EditVCPresenter.swift
//  CourseWork
//
//  Created by Артур Гайсин on 11.10.2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import Foundation
import RealmSwift

class EditVCPresenter{
    
    var realm: Realm!
    
    func save ( name: String, url: String){
        realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let linkItem = Link()
        linkItem.title = name
        linkItem.url = url
        try! self.realm.write {
            self.realm.add(linkItem)
        }
    }
}
