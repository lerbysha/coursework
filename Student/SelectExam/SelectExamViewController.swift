//
//  SelectExamViewController.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol SelectExamViewControllerInput: SelectExamPresenterOutput {
    func loadSubjects(with exams: [Exam])
    func loadNotes(with notes: [String])
}

protocol SelectExamViewControllerOutput {
    func loadSubjects()
}

public final class SelectExamViewController: UIViewController, SelectExamViewControllerInput {
    let contentView = SelectExamView()
    var output: SelectExamViewControllerOutput?
    var exams: [Exam] = []
    var updateSelectedExam = BehaviorRelay<SelectedExam?>(value: nil)
    var selectedExamName = ""
    var selectedExamType = ""
    let user: UserEntity = User.shared
    
    public override func loadView() {
        view = contentView
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        let logoLabelColor = UIColor(red: 0.08, green: 0.36, blue: 0.65, alpha: 1)
        navigationController?.navigationBar.tintColor = logoLabelColor
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        let title = "ЕГЭ и ГИА"
        let titleLabel = UILabel(
            text: title,
            font: UIFont.systemFont(ofSize: 24, weight: .bold),
            textColor: logoLabelColor,
            textAlignment: .center,
            numberOfLines: 1,
            lineBreakMode: .byWordWrapping,
            backgroundColor: .clear,
            adjustsFontSizeToFitWidth: false
        )
        navigationItem.titleView = titleLabel
        loadData()
        let examTapGesture = UITapGestureRecognizer(target: self, action: #selector(examTapped))
        let examTypeTapGesture = UITapGestureRecognizer(target: self, action: #selector(examTypeTapped))

        contentView.examView.addGestureRecognizer(examTapGesture)
        contentView.examTypeView.addGestureRecognizer(examTypeTapGesture)
        contentView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        updateSelectedExam.subscribe { event in
            guard let event = event.element as? SelectedExam else { return }
            switch event.isFrom {
            case .examName:
                (self.contentView.examView as SelectionView).setPlaceholderText(text: event.examName)
                self.selectedExamName = event.examName
            case .examType:
                (self.contentView.examTypeView as SelectionView).setPlaceholderText(text: event.examName)
                self.selectedExamType = event.examName
            default: break
            }
        }
    }
    
    @objc
    func submitButtonTapped() {
        user.examsIsFilled = true
        NotesDataStore.shared.exams.append(Exam(subject: Subject(id: 10, name: selectedExamName), examType: selectedExamType == "ЕГЭ" ? .ege : .gia, score: Int(contentView.scoreTextField.inputTextField.text ?? "0") ?? 0))
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    func examTapped() {
        let floatingPanel = FloatingPanelBulder()
        .build(
            contentVC: ParametrPickerConfigurator(isFrom: .examName, behaviorRelay: updateSelectedExam).configure()
        )
        self.present(floatingPanel, animated: true)
    }
    
    @objc
    func examTypeTapped() {
        let floatingPanel = FloatingPanelBulder()
        .build(
            contentVC: ParametrPickerConfigurator(isFrom: .examType, behaviorRelay: updateSelectedExam).configure()
        )
        self.present(floatingPanel, animated: true, completion: nil)
    }
    
    private func loadData() {
        contentView.showLoader()
        output?.loadSubjects()
    }
    
    func loadSubjects(with exams: [Exam]) {
        contentView.hideLoader()
        //contentView.insertSelectExam(exams)
    }
    
    func loadNotes(with notes: [String]) {
        contentView.hideLoader()
        //contentView.insertNotes(notes)
    }
    
    @objc
    func addSubjectsButtonTapped() {
        
    }

    // MARK: - Navigation

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
