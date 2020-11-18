//
//  SignUpConfigurator.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import Foundation

final class SignUpConfigurator {
    static let sharedInstance = SignUpConfigurator()
    
    func configure() -> UIViewController {
        let viewController = SignUpViewController()
        let interactor = SignUpInteractor()
        let presenter = SignUpPresenter()
        
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
