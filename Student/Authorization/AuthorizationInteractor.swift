//
//  AuthorizationInteractor.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AuthorizationInteractorInput: AuthorizationViewControllerOutput {
    func authorize(login: String, password: String)
}

protocol AuthorizationInteractorOutput {
    func authorize(authModel: AuthModel)
    func showErrorAlert(errorMessage: String)
}

final class AuthorizationInteractor: AuthorizationInteractorInput {
    var output: AuthorizationInteractorOutput?
    let provider = AuthorizationProvider()
    
    func authorize(login: String, password: String) {
        provider.emailAuth(email: login, password: password) { result in
            if result.success {
                self.output?.authorize(authModel: result)
            } else {
                self.output?.showErrorAlert(errorMessage: result.error_text)
            }
        }
    }
}
