//
//  AuthorizationConfigurator.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import Foundation

final class AuthorizationConfigurator {
    static let sharedInstance = AuthorizationConfigurator()
    
    func configure() -> UIViewController {
        let viewController = AuthorizationViewController()
        let interactor = AuthorizationInteractor()
        let presenter = AuthorizationPresenter()
        
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
