//
//  ParametrPickerViewController.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import RxCocoa

protocol ParametrPickerViewControllerInput: ParametrPickerPresenterOutput {
    func loadSubjects(with exams: [String])
}

protocol ParametrPickerViewControllerOutput {
    func loadSubjects()
}

public final class ParametrPickerViewController: UIViewController, ParametrPickerViewControllerInput {
    let contentView = ParametrPickerView()
    var output: ParametrPickerViewControllerOutput?
    var exams: [String] = []
    let isFromExamType: From
    var behaviorRelay: BehaviorRelay<SelectedExam?>?
    let dismissRelay = PublishRelay<Void>()
    
    public init(isFromExamType: From, behaviorRelay: BehaviorRelay<SelectedExam?>?) {
        self.isFromExamType = isFromExamType
        self.behaviorRelay = behaviorRelay
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        dismissRelay.subscribe { _ in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func loadData() {
        contentView.showLoader()
        output?.loadSubjects()
    }
    
    func loadSubjects(with exams: [String]) {
        contentView.hideLoader()
        contentView.insertExams(exams, isFromExamType: isFromExamType, behaviorRelay: behaviorRelay ?? nil, dismissRelay: dismissRelay)
    }

    // MARK: - Navigation

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
