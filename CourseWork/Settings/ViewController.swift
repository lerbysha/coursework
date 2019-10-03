//
//  ViewController.swift
//  CourseWork
//
//  Created by Артур Гайсин on 17/09/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "first", for: indexPath) as! FirstTableViewCell
            return cell
        }
        if indexPath.row == 1{
           let cell = tableView.dequeueReusableCell(withIdentifier: "lang", for: indexPath) as! MainVCTableViewCell
        
        
           

            return cell
            
        }
        if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "third", for: indexPath) as! ThirdTableViewCell
            return cell
        }
        else {
        let cell = tableView.dequeueReusableCell(withIdentifier: "third", for: indexPath) as! ThirdTableViewCell
        return cell
        }
       }
       

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            let alert = UIAlertController(title: "Выбрать язык", message: "", preferredStyle: UIAlertController.Style.actionSheet)
            alert.addAction(UIAlertAction(title: "Русский", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Английский", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

