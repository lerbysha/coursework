//
//  ApplicationFillingConfigurator.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import Foundation

final class ApplicationFillingConfigurator {
    static let sharedInstance = ApplicationFillingConfigurator()
    
    func configure() -> UIViewController {
        let viewController = ApplicationFillingViewController()
        let interactor = ApplicationFillingInteractor()
        let presenter = ApplicationFillingPresenter()
        
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
