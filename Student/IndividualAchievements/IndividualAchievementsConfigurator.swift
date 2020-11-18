//
//  IndividualAchievementsConfigurator.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import Foundation

final class IndividualAchievementsConfigurator {
    static let sharedInstance = IndividualAchievementsConfigurator()
    
    func configure() -> UIViewController {
        let viewController = IndividualAchievementsViewController()
        let interactor = IndividualAchievementsInteractor()
        let presenter = IndividualAchievementsPresenter()
        
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
