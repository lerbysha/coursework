//
//  ParametrPickerConfigurator.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import RxCocoa
import Foundation

public enum From {
    case examType
    case examName
    case schoolType
    case graduate
    case citizen
    case docsType
}

final class ParametrPickerConfigurator {
    var isFromExamType: From = .examName
    var behaviorRelay: BehaviorRelay<SelectedExam?>?
    static let sharedInstance = ParametrPickerConfigurator(isFrom: .docsType)
    
    public init(isFrom: From,
                behaviorRelay: BehaviorRelay<SelectedExam?>? = nil) {
        self.isFromExamType = isFrom
        self.behaviorRelay = behaviorRelay
    }
    
    func configure() -> UIViewController {
        let viewController = ParametrPickerViewController(isFromExamType: isFromExamType, behaviorRelay: behaviorRelay)
        let interactor = ParametrPickerInteractor(isFromExamType: isFromExamType)
        let presenter = ParametrPickerPresenter()
        
        viewController.output = interactor
        interactor.output = presenter
        presenter.output = viewController
        
        return viewController
    }
}
