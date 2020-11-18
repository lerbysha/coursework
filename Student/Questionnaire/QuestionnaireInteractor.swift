//
//  QuestionnaireInteractor.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation


protocol QuestionnaireInteractorInput: QuestionnaireViewControllerOutput {
    func authorize(login: String, password: String)
}

protocol QuestionnaireInteractorOutput {
    
}

final class QuestionnaireInteractor: QuestionnaireInteractorInput {
    func submit(questionnaireModel: QuestionnaireModel) {
        
    }
    
    var output: QuestionnaireInteractorOutput?
    let provider = QuestionnaireProvider()
    
    func authorize(login: String, password: String) {
        let result = provider.emailQuestionnaire(email: login, password: password)
        print(result)
    }
}
