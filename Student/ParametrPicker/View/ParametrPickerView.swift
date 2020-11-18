//
//  ParametrPickerView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa

public struct SelectedExam {
    let isFrom: From
    let examName: String
}

final class ParametrPickerView: UIView {
    private let appearance = Appearance()
    private var examNames: [String] = []
    private var isFromExamType: From = .examName
    var behaviorRelay: BehaviorRelay<SelectedExam?>? = nil
    var dismissRelay = PublishRelay<Void>()

    lazy var subjectsLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.subjects
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textColor = .logoLabelColor
        return label
    }()
    
    lazy var subjectsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        subjectsTableView.register(UITableViewCell.self, forCellReuseIdentifier: appearance.examsTableViewCellIdentifier)
        setupStyles()
        addSubviews()
        makeConstraints()
    }

    private func setupStyles() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addSubview(subjectsLabel)
        addSubview(subjectsTableView)
    }
    
    private func makeConstraints() {
        subjectsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(24)
        }
        subjectsTableView.snp.makeConstraints { make in
            make.top.equalTo(subjectsLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ParametrPickerView {
    public struct Appearance {
        let subjects = "Выберите нужный вариант"
        let examsTableViewCellIdentifier = "examsTableViewCellIdentifier"
    }
}

extension ParametrPickerView: UITableViewDataSource, UITableViewDelegate {
    func insertExams(_ examNames: [String], isFromExamType: From, behaviorRelay: BehaviorRelay<SelectedExam?>?, dismissRelay: PublishRelay<Void>) {
        self.examNames = examNames
        self.isFromExamType = isFromExamType
        self.behaviorRelay = behaviorRelay
        self.dismissRelay = dismissRelay
        DispatchQueue.main.async {
            self.subjectsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = subjectsTableView.dequeueReusableCell(withIdentifier: appearance.examsTableViewCellIdentifier) else { return UITableViewCell()}
        cell.textLabel?.text = examNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        behaviorRelay?.accept(SelectedExam(isFrom: isFromExamType, examName: examNames[indexPath.row]))
        dismissRelay.accept(())
    }
}
