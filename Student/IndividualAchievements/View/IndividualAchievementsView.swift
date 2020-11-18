//
//  IndividualAchievementsView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa

final class IndividualAchievementsView: UIView {
    private let appearance = Appearance()
    private let dataStore = AchievementsDataStore.shared
    var behaviorRelay: BehaviorRelay<SelectAchievement> = BehaviorRelay<SelectAchievement>(value: SelectAchievement(index: 0, isSelected: false))
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var achievementsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(appearance.submit, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .logoLabelColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
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
        achievementsTableView.register(IndividualAchievementsTableViewCell.self, forCellReuseIdentifier: appearance.achievementsTableViewCellIdentifier)
        setupStyles()
        addSubviews()
        makeConstraints()
    }

    private func setupStyles() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addSubview(achievementsTableView)
        addSubview(submitButton)
    }
    
    private func makeConstraints() {
        submitButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(appearance.buttonHeigh)
            make.bottom.equalToSuperview().inset(32)
        }
        achievementsTableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(submitButton.snp.top).offset(-8)
        }
    }
}

extension IndividualAchievementsView {
    public struct Appearance {
        let buttonHeigh: CGFloat = 36
        let submit = "Сохранить"
        let achievementsTableViewCellIdentifier = "achievementsTableViewCellIdentifier"
    }
}

extension IndividualAchievementsView: UITableViewDelegate, UITableViewDataSource {
    func insertBehaviorRelay(behaviorRelay: BehaviorRelay<SelectAchievement>) {
        self.behaviorRelay = behaviorRelay
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = achievementsTableView.dequeueReusableCell(withIdentifier: appearance.achievementsTableViewCellIdentifier) as? IndividualAchievementsTableViewCell else { return UITableViewCell()}
        cell.selectAchievementButton.rx.tap.bind { [weak self] _ in
            cell.selectAchievementButton.isSelected = !cell.selectAchievementButton.isSelected
            self?.behaviorRelay.accept(SelectAchievement(index: indexPath.row, isSelected: cell.selectAchievementButton.isSelected))
        }
        if dataStore.notes[indexPath.row] != "прикрепить" {
            cell.achievementInfoLabel.text = dataStore.notes[indexPath.row]
            return cell
        } else {
            return SelectedIndividualAchievementView()
        }
    }
}

struct SelectAchievement {
    let index: Int
    let isSelected: Bool
}
