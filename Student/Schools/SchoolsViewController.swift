//
//  SchoolsViewController.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import RxCocoa

protocol SchoolsViewControllerInput: SchoolsPresenterOutput {
    
}

protocol SchoolsViewControllerOutput {
    func authorize(login: String, password: String)
}

class SchoolsViewController: UIViewController, SchoolsViewControllerInput {
    let contentView = SchoolsView()
    var output: SchoolsViewControllerOutput?
    let user: UserEntity = User.shared
    var updateSchools = BehaviorRelay<SelectedExam?>(value: nil)
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let logoLabelColor = UIColor(red: 0.08, green: 0.36, blue: 0.65, alpha: 1)
        navigationController?.navigationBar.tintColor = logoLabelColor
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        let title = "Учебные заведения"
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
        contentView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        let schoolTypeTapGesture = UITapGestureRecognizer(target: self, action: #selector(schoolTypeTapped))
        let graduateTapGesture = UITapGestureRecognizer(target: self, action: #selector(graduateTapped))
        
        contentView.typeOfSchoolView.addGestureRecognizer(schoolTypeTapGesture)
        contentView.typeOfEducationView.addGestureRecognizer(graduateTapGesture)
        updateSchools.subscribe { event in
            guard let event = event.element as? SelectedExam else { return }
            switch event.isFrom {
            case .schoolType:
                (self.contentView.typeOfSchoolView as SelectionView).setPlaceholderText(text: event.examName)
            case .graduate:
                (self.contentView.typeOfEducationView as SelectionView).setPlaceholderText(text: event.examName)
            default: break
            }
        }
    }
    
    @objc
    private func schoolTypeTapped() {
        let floatingPanel = FloatingPanelBulder()
        .build(
            contentVC: ParametrPickerConfigurator(isFrom: .schoolType, behaviorRelay: updateSchools).configure()
        )
        self.present(floatingPanel, animated: true)
    }
    
    @objc
    private func graduateTapped() {
        let floatingPanel = FloatingPanelBulder()
        .build(
            contentVC: ParametrPickerConfigurator(isFrom: .graduate, behaviorRelay: updateSchools).configure()
        )
        self.present(floatingPanel, animated: true)
    }
    
    @objc
    private func submitButtonTapped() {
        user.schoolsIsFilled = true
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
    }
}
