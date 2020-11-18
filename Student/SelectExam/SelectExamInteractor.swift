
import Foundation
import RxSwift
import RxCocoa

protocol SelectExamInteractorInput: SelectExamViewControllerOutput {
    func loadSubjects()
}

protocol SelectExamInteractorOutput {
    func loadSubjects(with exams: [Exam])
    func loadNotes(with notes: [String])
}

final class SelectExamInteractor: SelectExamInteractorInput {
    var output: SelectExamInteractorOutput?
    let provider = SelectExamProvider()
    let user: UserEntity = User.shared
    
    func loadSubjects() {
//        provider.getSelectExamOfUser(userID: user.userID, userSession: user.userSession) { result in
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
