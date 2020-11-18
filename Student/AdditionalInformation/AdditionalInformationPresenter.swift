//
//  AdditionalInformationPresenter.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation

protocol AdditionalInformationPresenterInput: AdditionalInformationInteractorOutput {
    
}

protocol AdditionalInformationPresenterOutput {
    
}

final class AdditionalInformationPresenter: AdditionalInformationPresenterInput {
    var output: AdditionalInformationPresenterOutput?
    
    
}
