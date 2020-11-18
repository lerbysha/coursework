//
//  QuestionnaireConfigurator.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import Foundation

final class QuestionnaireConfigurator {
    static let sharedInstance = QuestionnaireConfigurator()
    
    func configure() -> UIViewController {
        let viewController = QuestionnaireViewController()
        let interactor = QuestionnaireInteractor()
        let presenter = QuestionnairePresenter()
        
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
