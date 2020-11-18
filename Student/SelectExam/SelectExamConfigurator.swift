//
//  SelectExamConfigurator.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import Foundation

final class SelectExamConfigurator {
    static let sharedInstance = SelectExamConfigurator()
    
    func configure() -> UIViewController {
        let viewController = SelectExamViewController()
        let interactor = SelectExamInteractor()
        let presenter = SelectExamPresenter()
        
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
