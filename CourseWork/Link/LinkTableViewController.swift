//
//  MainTableViewController.swift
//  CourseWork
//
//  Created by Артур Гайсин on 19/09/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import UIKit
import RealmSwift

class LinkTableViewController: UITableViewController {
    
    var realm : Realm!
    var url : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()

        print(linkList.count)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    lazy var linkList: Results<Link> = { self.realm.objects(Link.self) }()
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return linkList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! LinkTableViewCell

        cell.titleLabel.text = linkList[indexPath.row].title
        cell.detailLabel.text = linkList[indexPath.row].url
        return cell
    }
    
    @IBAction func didUnwindFromVC(_ sender:UIStoryboardSegue){
       }
 

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
      

            try! self.realm.write {
                self.realm.delete((linkList[indexPath.row]))
                }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
    
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        url = linkList[indexPath.row].url
        let vc = StatTableViewController()
        vc.url = url
        navigationController?.pushViewController(vc, animated: true)

    }
   
    

}
