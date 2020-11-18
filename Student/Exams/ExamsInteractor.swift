//
//  ExamsInteractor.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ExamsInteractorInput: ExamsViewControllerOutput {
    func loadSubjects()
}

protocol ExamsInteractorOutput {
    func loadSubjects(with exams: [Exam])
    func loadNotes(with notes: [String])
}

final class ExamsInteractor: ExamsInteractorInput {
    var output: ExamsInteractorOutput?
    let provider = ExamsProvider()
    let user: UserEntity = User.shared
    
    func loadSubjects() {
//        provider.getExamsOfUser(userID: user.userID, userSession: user.userSession) { result in
//            if result.success {
//                self.output?.authorize(authModel: result)
//            } else {
//                self.output?.showErrorAlert(errorMessage: result.error_text)
//            }
//        }
        output?.loadSubjects(with: NotesDataStore.shared.exams)
        
        output?.loadNotes(with: NotesDataStore.shared.notes)
    }
}
