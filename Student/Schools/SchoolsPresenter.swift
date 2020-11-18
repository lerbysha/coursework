//
//  SchoolsPresenter.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation

protocol SchoolsPresenterInput: SchoolsInteractorOutput {
    
}

protocol SchoolsPresenterOutput {
    
}

final class SchoolsPresenter: SchoolsPresenterInput {
    var output: SchoolsPresenterOutput?
}
