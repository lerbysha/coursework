//
//  AdditionalInformationInteractor.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AdditionalInformationInteractorInput: AdditionalInformationViewControllerOutput {
    
}

protocol AdditionalInformationInteractorOutput {
    
}

final class AdditionalInformationInteractor: AdditionalInformationInteractorInput {
    var output: AdditionalInformationInteractorOutput?
    let provider = AdditionalInformationProvider()
    
    
}
