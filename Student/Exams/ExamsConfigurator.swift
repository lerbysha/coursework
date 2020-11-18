//
//  ExamsConfigurator.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import Foundation

final class ExamsConfigurator {
    static let sharedInstance = ExamsConfigurator()
    
    func configure() -> UIViewController {
        let viewController = ExamsViewController()
        let interactor = ExamsInteractor()
        let presenter = ExamsPresenter()
        
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
