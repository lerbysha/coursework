//
//  SignUpViewController.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit

protocol SignUpViewControllerInput: SignUpPresenterOutput {
    func dismiss()
}

protocol SignUpViewControllerOutput {
    func submit(signUpModel: SignUpModel)
}

class SignUpViewController: UIViewController, SignUpViewControllerInput {
    let contentView = SignUpView()
    var output: SignUpViewControllerOutput?
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoLabelColor = UIColor(red: 0.08, green: 0.36, blue: 0.65, alpha: 1)
        navigationController?.navigationBar.tintColor = logoLabelColor
        navigationController?.navigationBar.topItem?.title = ""
        let title = "Регистрация"
        let titleLabel = UILabel(
            text: title,
            font: UIFont.systemFont(ofSize: 24, weight: .bold),
            textColor: logoLabelColor,
            textAlignment: .center,
            numberOfLines: 1,
            lineBreakMode: .byWordWrapping,
            backgroundColor: .clear,
            adjustsFontSizeToFitWidth: false
        )
        navigationItem.titleView = titleLabel
        contentView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func submitButtonTapped() {
        output?.submit(signUpModel: SignUpModel(
            name: contentView.firstNameTextField.inputTextField.text ?? "",
            lastName: contentView.lastNameTextField.inputTextField.text ?? "",
            secondName: contentView.secondNameTextField.inputTextField.text ?? "",
            email: contentView.emailTextField.inputTextField.text ?? "",
            password: contentView.passwordTextField.inputTextField.text ?? "",
            repeatPassword: contentView.repeatPasswordTextField.inputTextField.text ?? "",
            processingOfPersonalData: contentView.checkbox.isSelected)
        )
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
