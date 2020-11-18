//
//  SignUpInteractor.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation


protocol SignUpInteractorInput: SignUpViewControllerOutput {
    func submit(signUpModel: SignUpModel)
}

protocol SignUpInteractorOutput {
    func dismiss()
}

final class SignUpInteractor: SignUpInteractorInput {
    var output: SignUpInteractorOutput?
    var signUpProvider: SignUpProviderProtocol = SignUpProvider()
    
    func submit(signUpModel: SignUpModel) {
        signUpProvider.signUp(signUpModel: signUpModel) { result in
            print(result)
            self.output?.dismiss()
        }
    }
}
