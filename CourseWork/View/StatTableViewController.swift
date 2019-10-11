//
//  StatTableViewController.swift
//  CourseWork
//
//  Created by Артур Гайсин on 02/10/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import UIKit

class StatTableViewController: UITableViewController {
    
    var url : String = ""
    let manager = StatManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.getStat(url: url)

       
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
