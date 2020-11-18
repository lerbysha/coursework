//
//  IndividualAchievementsPresenter.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

protocol IndividualAchievementsPresenterInput: IndividualAchievementsInteractorOutput {
    func loadSubjects(with exams: [Exam])
    func loadNotes(with notes: [String])
}

protocol IndividualAchievementsPresenterOutput {
    func loadSubjects(with exams: [Exam])
    func loadNotes(with notes: [String])
}

final class IndividualAchievementsPresenter: IndividualAchievementsPresenterInput {
    var output: IndividualAchievementsPresenterOutput?
    
    func loadSubjects(with exams: [Exam]) {
        output?.loadSubjects(with: exams)
    }
    
    func loadNotes(with notes: [String]) {
        output?.loadNotes(with: notes)
    }
}
