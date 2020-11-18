//
//  SchoolsInteractor.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation

protocol SchoolsInteractorInput: SchoolsViewControllerOutput {
    func authorize(login: String, password: String)
}

protocol SchoolsInteractorOutput {
    
}

final class SchoolsInteractor: SchoolsInteractorInput {
    var output: SchoolsInteractorOutput?
//    let provider = SchoolsProvider()
    
    func authorize(login: String, password: String) {
        
    }
}
