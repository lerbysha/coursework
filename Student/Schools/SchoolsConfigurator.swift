//
//  SchoolsConfigurator.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import Foundation

final class SchoolsConfigurator {
    static let sharedInstance = SchoolsConfigurator()
    
    func configure() -> UIViewController {
        let viewController = SchoolsViewController()
        let interactor = SchoolsInteractor()
        let presenter = SchoolsPresenter()
        
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
