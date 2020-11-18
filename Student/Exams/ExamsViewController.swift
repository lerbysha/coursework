//
//  ExamsViewController.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit

protocol ExamsViewControllerInput: ExamsPresenterOutput {
    func loadSubjects(with exams: [Exam])
    func loadNotes(with notes: [String])
}

protocol ExamsViewControllerOutput {
    func loadSubjects()
}

public final class ExamsViewController: UIViewController, ExamsViewControllerInput {
    let contentView = ExamsView()
    var output: ExamsViewControllerOutput?
    var exams: [Exam] = []
    
    public override func loadView() {
        view = contentView
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
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
        contentView.addSubjectsButton.addTarget(self, action: #selector(addSubjectsButtonTapped), for: .touchUpInside)
    }
    
    private func loadData() {
        contentView.showLoader()
        output?.loadSubjects()
    }
    
    func loadSubjects(with exams: [Exam]) {
        contentView.hideLoader()
        contentView.insertExams(exams)
    }
    
    func loadNotes(with notes: [String]) {
        contentView.hideLoader()
        contentView.insertNotes(notes)
    }
    
    @objc
    func addSubjectsButtonTapped() {
        self.show(SelectExamConfigurator.sharedInstance.configure(), sender: nil)
    }

    // MARK: - Navigation

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
