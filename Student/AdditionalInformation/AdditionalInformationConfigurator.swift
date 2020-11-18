//
//  AdditionalInformationConfigurator.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import Foundation

final class AdditionalInformationConfigurator {
    static let sharedInstance = AdditionalInformationConfigurator()
    
    func configure() -> UIViewController {
        let viewController = AdditionalInformationViewController()
        let interactor = AdditionalInformationInteractor()
        let presenter = AdditionalInformationPresenter()
        
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
