//
//  NumbersViewController.swift
//  CourseWork
//
//  Created by Артур Гайсин on 03/10/2019.
//  Copyright © 2019 Артур Гайсин. All rights reserved.
//

import UIKit

class NumbersViewController: UIViewController {
    
    var presenter = NumbersApiPresenter()
    var answer = ""
    let manager = APIManager()
    
    @IBAction func mathButton(_ sender: Any) {
        
        self.answer = presenter.getMathStat()
        let alert = UIAlertController(title: "\(self.answer)", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dateButton(_ sender: Any) {
        self.answer = presenter.getDateStat()
        let alert = UIAlertController(title: "\(self.answer)", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func triviaButton(_ sender: Any) {
        self.answer = presenter.getTriviaStat()
        let alert = UIAlertController(title: "\(self.answer)", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
