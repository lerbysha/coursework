//
//  SignUpPresenter.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation

protocol SignUpPresenterInput: SignUpInteractorOutput {
    func dismiss()
}

protocol SignUpPresenterOutput {
    func dismiss()
}

final class SignUpPresenter: SignUpPresenterInput {
    var output: SignUpPresenterOutput?
    
    func dismiss() {
        output?.dismiss()
    }
}
