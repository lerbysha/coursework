//
//  EditViewController.swift
//  CourseWork
//
//  Created by Артур Гайсин on 19/09/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class EditViewController: UIViewController {

    var realm: Realm!
    
    

    var name: String = ""
    var url: String = ""

    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var urlTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        name = nameTF.text!
        url = urlTF.text!
        save(name: name, url: url)
        
    }
    
    func save(name:String, url: String) {
        let linkItem = Link()
        linkItem.title = name
        linkItem.url = url
        try! self.realm.write {
            self.realm.add(linkItem)
        }
    }
   

}
