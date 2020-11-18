//
//  AdditionalInformationViewController.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit

protocol AdditionalInformationViewControllerInput: AdditionalInformationPresenterOutput {
}

protocol AdditionalInformationViewControllerOutput {
}

class AdditionalInformationViewController: UIViewController, AdditionalInformationViewControllerInput {
    let contentView = AdditionalInformationView()
    var output: AdditionalInformationViewControllerOutput?
    let user: UserEntity = User.shared
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .logoLabelColor
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        let title = "Дополнительная информация"
        let titleLabel = UILabel(
            text: title,
            font: UIFont.systemFont(ofSize: 22, weight: .bold),
            textColor: .logoLabelColor,
            textAlignment: .center,
            numberOfLines: 1,
            lineBreakMode: .byWordWrapping,
            backgroundColor: .clear,
            adjustsFontSizeToFitWidth: false
        )
        navigationItem.titleView = titleLabel
        contentView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        contentView.checkbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
    }
    
    @objc
    private func submitButtonTapped() {
        user.additionalInformationIsFilled = true
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func checkboxTapped() {
        contentView.checkbox.isSelected = !contentView.checkbox.isSelected
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
