//
//  AuthorizationPresenter.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation

protocol AuthorizationPresenterInput: AuthorizationInteractorOutput {
    func authorize(authModel: AuthModel)
    func showErrorAlert(errorMessage: String)
}

protocol AuthorizationPresenterOutput {
    func authorize(authModel: AuthModel)
    func showErrorAlert(errorMessage: String)
}

final class AuthorizationPresenter: AuthorizationPresenterInput {
    var output: AuthorizationPresenterOutput?
    
    func authorize(authModel: AuthModel) {
        output?.authorize(authModel: authModel)
    }
    
    func showErrorAlert(errorMessage: String) {
        output?.showErrorAlert(errorMessage: errorMessage)
    }
}
