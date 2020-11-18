//
//  ParametrPickerPresenter.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

protocol ParametrPickerPresenterInput: ParametrPickerInteractorOutput {
    func loadSubjects(with exams: [String])
}

protocol ParametrPickerPresenterOutput {
    func loadSubjects(with exams: [String])
}

final class ParametrPickerPresenter: ParametrPickerPresenterInput {
    var output: ParametrPickerPresenterOutput?
    
    func loadSubjects(with exams: [String]) {
        output?.loadSubjects(with: exams)
    }
}
