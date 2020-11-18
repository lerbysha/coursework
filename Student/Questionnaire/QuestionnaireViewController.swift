//
//  QuestionnaireViewController.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import RxCocoa

protocol QuestionnaireViewControllerInput: QuestionnairePresenterOutput {
    
}

protocol QuestionnaireViewControllerOutput {
    func submit(questionnaireModel: QuestionnaireModel)
}

class QuestionnaireViewController: UIViewController, QuestionnaireViewControllerInput {
    let contentView = QuestionnaireView()
    var output: QuestionnaireViewControllerOutput?
    let user: UserEntity = User.shared
    var updateQuestionnaire = BehaviorRelay<SelectedExam?>(value: nil)
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        contentView.maleButton.addTarget(self, action: #selector(maleButtonTapped), for: .touchUpInside)
        contentView.femaleButton.addTarget(self, action: #selector(femaleButtonTapped), for: .touchUpInside)
        
        let citizenshipViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(citizenshipViewTapped))
        let examTypeTapGesture = UITapGestureRecognizer(target: self, action: #selector(docsTypeTapped))
        
        contentView.citizenshipView.addGestureRecognizer(citizenshipViewTapGesture)
        contentView.documentView.addGestureRecognizer(examTypeTapGesture)
        updateQuestionnaire.subscribe { event in
            guard let event = event.element as? SelectedExam else { return }
            switch event.isFrom {
            case .citizen:
                (self.contentView.citizenshipView as SelectionView).setPlaceholderText(text: event.examName)
            case .docsType:
                (self.contentView.documentView as SelectionView).setPlaceholderText(text: event.examName)
            default: break
            }
        }
    }
    
    @objc
    private func citizenshipViewTapped() {
        let floatingPanel = FloatingPanelBulder()
        .build(
            contentVC: ParametrPickerConfigurator(isFrom: .citizen, behaviorRelay: updateQuestionnaire).configure()
        )
        self.present(floatingPanel, animated: true)
    }
    
    @objc
    private func docsTypeTapped() {
        let floatingPanel = FloatingPanelBulder()
        .build(
            contentVC: ParametrPickerConfigurator(isFrom: .docsType, behaviorRelay: updateQuestionnaire).configure()
        )
        self.present(floatingPanel, animated: true)
    }
    
    @objc
    private func submitButtonTapped() {
        user.questionnaireIsFilled = true
        output?.submit(questionnaireModel: QuestionnaireModel(
            lastName: contentView.lastNameTextField.inputTextField.text ?? "",
            firstName: contentView.firstNameTextField.inputTextField.text ?? "",
            secondName: contentView.secondNameTextField.inputTextField.text ?? "",
            birthDate: contentView.birthdateTextField.inputTextField.text ?? "",
            sex: contentView.maleButton.isSelected ? true : false,
            phoneNumber: "",
            citizenship: "",
            typeOfDocument: "",
            shortNumberOfDocument: 0,
            longNumberOfDocument: 0,
            dateOfGetting: "",
            givenByWhom: "",
            code: 0,
            inn: 0,
            insurance: 0)
        )
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func maleButtonTapped() {
        contentView.maleButton.isSelected = true
        contentView.femaleButton.isSelected = false
    }
    
    @objc
    private func femaleButtonTapped() {
        contentView.maleButton.isSelected = false
        contentView.femaleButton.isSelected = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationControllerInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func navigationControllerInit() {
        let logoLabelColor = UIColor.logoLabelColor
        navigationController?.navigationBar.tintColor = logoLabelColor
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        let title = "Анкета"
        let titleLabel = UILabel(
            text: title,
            font: UIFont.systemFont(ofSize: 24, weight: .bold),
            textColor: logoLabelColor,
            textAlignment: .center,
            numberOfLines: 1,
            lineBreakMode: .byWordWrapping,
            backgroundColor: .white,
            adjustsFontSizeToFitWidth: false
        )
        navigationItem.titleView = titleLabel
    }
}

extension UINavigationController {
    public func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
}
