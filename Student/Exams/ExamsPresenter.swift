//
//  ExamsPresenter.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

protocol ExamsPresenterInput: ExamsInteractorOutput {
    func loadSubjects(with exams: [Exam])
    func loadNotes(with notes: [String])
}

protocol ExamsPresenterOutput {
    func loadSubjects(with exams: [Exam])
    func loadNotes(with notes: [String])
}

final class ExamsPresenter: ExamsPresenterInput {
    var output: ExamsPresenterOutput?
    
    func loadSubjects(with exams: [Exam]) {
        output?.loadSubjects(with: exams)
    }
    
    func loadNotes(with notes: [String]) {
        output?.loadNotes(with: notes)
    }
}
