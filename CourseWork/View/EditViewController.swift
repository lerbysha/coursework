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

    private let presenter = EditVCPresenter()
    
    

    var name: String = ""
    var url: String = ""

    
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var urlTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        name = nameTF.text!
        url = urlTF.text!
        presenter.save(name: name, url: url)
        
    }
    
    
    
   

}
