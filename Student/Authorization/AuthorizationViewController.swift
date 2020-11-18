//
//  AuthorizationViewController.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import SafariServices
import NotificationCenter

protocol AuthorizationViewControllerInput: AuthorizationPresenterOutput {
    func authorize(authModel: AuthModel)
    func showErrorAlert(errorMessage: String)
}

protocol AuthorizationViewControllerOutput {
    func authorize(login: String, password: String)
}

class AuthorizationViewController: UIViewController, AuthorizationViewControllerInput {
    let contentView = AuthorizationView()
    var output: AuthorizationViewControllerOutput?
    
    override func loadView() {
        view = contentView
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        contentView.forgotPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
//        contentView.signUpButton.addTarget(self, action: #selector(signup), for: .touchUpInside)
        contentView.submitButton.addTarget(self, action: #selector(signin), for: .touchUpInside)
    }
    
    @objc
    private func forgotPassword() {
        let viewController = SFSafariViewController(url: URL(string: "")!)
        self.show(viewController, sender: nil)
    }
    
    @objc
    private func signup() {
        self.show(SignUpConfigurator.sharedInstance.configure(), sender: nil)
    }

    @objc
    private func signin() {
        self.show(ApplicationFillingConfigurator.sharedInstance.configure(), sender: nil)
    }
    
    func authorize(authModel: AuthModel) {
        self.show(QuestionnaireConfigurator.sharedInstance.configure(), sender: nil)
    }
    
    func showErrorAlert(errorMessage: String) {
        self.showAlert(title: "Error", message: errorMessage)
    }
}

extension UIViewController {
    public func showAlert(title: String?, message: String?, buttonTitles: [String]? = nil, highlightedButtonIndex: Int? = nil, completion: ((Int) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var allButtons = buttonTitles ?? [String]()
        if allButtons.count == 0 {
            allButtons.append("OK")
        }

        for index in 0..<allButtons.count {
            let buttonTitle = allButtons[index]
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion?(index)
            })
            alertController.addAction(action)
            if let highlightedButtonIndex = highlightedButtonIndex, index == highlightedButtonIndex {
                if #available(iOS 9.0, *) {
                    alertController.preferredAction = action
                }
            }
        }
        present(alertController, animated: true, completion: nil)
        return alertController
    }
}
