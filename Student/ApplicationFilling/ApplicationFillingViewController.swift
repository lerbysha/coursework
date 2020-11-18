//
//  ApplicationFillingViewController.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ApplicationFillingViewControllerInput: ApplicationFillingPresenterOutput {
    func loadSubjects(with exams: [Exam])
    func loadNotes(with notes: [String])
}

protocol ApplicationFillingViewControllerOutput {
    func loadSubjects()
}

public final class ApplicationFillingViewController: UIViewController, ApplicationFillingViewControllerInput {
    let contentView = ApplicationFillingView()
    var output: ApplicationFillingViewControllerOutput?
    var behaviorRelay: BehaviorRelay<Int?> = BehaviorRelay<Int?>(value: 0)
    var exams: [Exam] = []
    let user: UserEntity = User.shared
    
    public override func loadView() {
        view = contentView
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        loadTableViewCell()
        contentView.sectionsTableView.reloadData()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        let logoLabelColor = UIColor(red: 0.08, green: 0.36, blue: 0.65, alpha: 1)
        navigationController?.navigationBar.tintColor = logoLabelColor
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        let title = "Подача заявления"
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
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: infoButton)
        self.navigationItem.rightBarButtonItem = barButton
        loadTableViewCell()
        behaviorRelay.skip(1).subscribe(onNext: { index in
            switch index {
            case 0:
                self.show(QuestionnaireConfigurator.sharedInstance.configure(), sender: nil)
            case 1:
                return
            case 2:
                self.show(SchoolsConfigurator.sharedInstance.configure(), sender: nil)
            case 3:
                self.show(AdditionalInformationConfigurator.sharedInstance.configure(), sender: nil)
            case 4:
                self.show(ExamsConfigurator.sharedInstance.configure(), sender: nil)
            case 5:
                self.show(IndividualAchievementsConfigurator.sharedInstance.configure(), sender: nil)
            case 6:
                return
            default:
                return
            }
        })
    }
    
    private func loadTableViewCell() {
        contentView.insertSections(behaviorRelay: behaviorRelay, [
            ApplicationSection(name: "Анкета", isFilled: user.questionnaireIsFilled, image: UIImage(named: "ic_questionnaire") ?? UIImage()),
            ApplicationSection(name: "Адрес", isFilled: false, image: UIImage(named: "ic_address") ?? UIImage()),
            ApplicationSection(name: "Учебные заведения", isFilled: user.schoolsIsFilled, image: UIImage(named: "ic_schools") ?? UIImage()),
            ApplicationSection(name: "Доп. информация", isFilled: user.additionalInformationIsFilled, image: UIImage(named: "ic_additionalInfo") ?? UIImage()),
            ApplicationSection(name: "ЕГЭ и ГИА", isFilled: user.examsIsFilled, image: UIImage(named: "ic_editButton") ?? UIImage()),
            ApplicationSection(name: "Индивидуальные достижения", isFilled: user.individualAchievementsIsFilled, image: UIImage(named: "ic_individualAchievements") ?? UIImage()),
            ApplicationSection(name: "Прикрепленные документы", isFilled: false, image: UIImage(named: "ic_pinned") ?? UIImage()),
            ]
        )
    }
    
    private func loadData() {
        contentView.showLoader()
        output?.loadSubjects()
    }
    
    func loadSubjects(with exams: [Exam]) {
        contentView.hideLoader()
        //contentView.insertApplicationFilling(exams)
    }
    
    func loadNotes(with notes: [String]) {
        contentView.hideLoader()
        //contentView.insertNotes(notes)
    }
    
    @objc
    func addSubjectsButtonTapped() {
        self.show(SelectExamConfigurator.sharedInstance.configure(), sender: nil)
    }
    
    @objc
    func infoButtonTapped() {
        self.show(ApplicationFillingHelpViewController(), sender: nil)
    }

    // MARK: - Navigation

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
