//
//  IndividualAchievementsViewController.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit
import RxCocoa

protocol IndividualAchievementsViewControllerInput: IndividualAchievementsPresenterOutput {
    func loadSubjects(with exams: [Exam])
    func loadNotes(with notes: [String])
}

protocol IndividualAchievementsViewControllerOutput {
    func loadSubjects()
}

public final class IndividualAchievementsViewController: UIViewController, IndividualAchievementsViewControllerInput {
    let contentView = IndividualAchievementsView()
    var output: IndividualAchievementsViewControllerOutput?
    var behaviorRelay: BehaviorRelay<SelectAchievement> = BehaviorRelay<SelectAchievement>(value: SelectAchievement(index: 0, isSelected: false))
    let user: UserEntity = User.shared
    var notes = AchievementsDataStore.shared.notes
    
    public override func loadView() {
        view = contentView
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = false
        loadData()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        let logoLabelColor = UIColor(red: 0.08, green: 0.36, blue: 0.65, alpha: 1)
        navigationController?.navigationBar.tintColor = logoLabelColor
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
        let title = "Индивидуальные достижения"
        let titleLabel = UILabel(
            text: title,
            font: UIFont.systemFont(ofSize: 20, weight: .bold),
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
        contentView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        behaviorRelay.skip(1).subscribe({ item in
            if let item = item.element, item.isSelected {
                AchievementsDataStore.shared.notes.insert("прикрепить", at: item.index + 1)
                self.contentView.achievementsTableView.reloadData()
            } else if let item = item.element, item.isSelected == false {
                AchievementsDataStore.shared.notes.remove(at: item.index + 1)
                self.contentView.achievementsTableView.reloadData()
            }
        })
    }
    
    @objc
    private func submitButtonTapped() {
        user.individualAchievementsIsFilled = true
        navigationController?.popViewController(animated: true)
    }
    
    
    private func loadData() {
        contentView.showLoader()
        contentView.insertBehaviorRelay(behaviorRelay: behaviorRelay)
        output?.loadSubjects()
    }
    
    func loadSubjects(with exams: [Exam]) {
        contentView.hideLoader()
    }
    
    func loadNotes(with notes: [String]) {
        contentView.hideLoader()
    }
    
    @objc
    func infoButtonTapped() {
        let floatingPanel = FloatingPanelBulder()
            .build(
                contentVC: IndividualAchievementsHelpViewController()
        )
        self.present(floatingPanel, animated: true)
    }
    
    @objc
    func addSubjectsButtonTapped() {
        self.show(SelectExamConfigurator.sharedInstance.configure(), sender: nil)
    }

    // MARK: - Navigation

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
