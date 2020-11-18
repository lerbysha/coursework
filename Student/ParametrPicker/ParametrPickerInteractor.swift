//
//  ParametrPickerInteractor.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol ParametrPickerInteractorInput: ParametrPickerViewControllerOutput {
    func loadSubjects()
}

protocol ParametrPickerInteractorOutput {
    func loadSubjects(with exams: [String])
}

final class ParametrPickerInteractor: ParametrPickerInteractorInput {
    var output: ParametrPickerInteractorOutput?
    let provider = ParametrPickerProvider()
    let user: UserEntity = User.shared
    let isFromExamType: From
    
    public init(isFromExamType: From) {
        self.isFromExamType = isFromExamType
    }
    
    func loadSubjects() {
//        provider.getParametrPickerOfUser(userID: user.userID, userSession: user.userSession) { result in
//            if result.success {
//                self.output?.authorize(authModel: result)
//            } else {
//                self.output?.showErrorAlert(errorMessage: result.error_text)
//            }
//        }
        switch isFromExamType {
        case .examName:
            output?.loadSubjects(with: [
                "Русский Язык",
                "Математика",
                "Английский Язык",
                "Немецкий язык",
                "География",
                "Биология",
                "Физика",
                "Химия",
                "Литература",
                "История",
                "Обществознание"
            ])
        case .examType:
            output?.loadSubjects(with: [
                "ЕГЭ",
                "ГИА"
            ])
        case .citizen:
            output?.loadSubjects(with: [
                "Университет",
                "Школа",
                "Гимназия"
            ])
        case .docsType:
            output?.loadSubjects(with: [
                "Паспорт",
                "Военный билет",
                "Вид на жительство",
                "Загранпаспорт гражданина РФ"
            ])
        case .graduate:
            output?.loadSubjects(with: [
                "Высшее",
                "Среднее",
                "Средне-специальное"
            ])
        case .schoolType:
            output?.loadSubjects(with: [
                "Университет",
                "Школа",
                "Гимназия",
                "Лицей",
                "Техникум"
            ])
        }
    }
}
