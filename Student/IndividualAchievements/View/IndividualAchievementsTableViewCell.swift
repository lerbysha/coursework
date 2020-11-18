//
//  IndividualAchievementsTableViewCell.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class IndividualAchievementsTableViewCell: UITableViewCell {
    private let appearance = Appearance()
    
    lazy var containerView: UIView = {
       let view = UIView()
       view.backgroundColor = .white
       return view
    }()
    
    lazy var achievementInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    lazy var selectAchievementButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        selectionStyle = .none
        backgroundColor = .white
        setupStyles()
        addSubviews()
        makeConstraints()
    }

    private func setupStyles() {
        selectAchievementButton.setImage(UIImage(named: "ic_selectedCheckbox"), for: .selected)
        selectAchievementButton.setImage(UIImage(named: "ic_checkbox"), for: .normal)
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(achievementInfoLabel)
        containerView.addSubview(selectAchievementButton)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        selectAchievementButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerX.equalTo(achievementInfoLabel)
            make.height.width.equalTo(24)
        }
        achievementInfoLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(4)
            make.trailing.equalTo(selectAchievementButton.snp.leading).offset(-8)
        }
    }
}

extension IndividualAchievementsTableViewCell {
    struct Appearance {
    }
}
