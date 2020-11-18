//
//  SelectedIndividualAchievementView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class SelectedIndividualAchievementView: UITableViewCell {
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
        label.text = appearance.achievementInfoLabel
        return label
    }()
    
    lazy var selectAchievementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(appearance.submit, for: .normal)
        button.setTitleColor(.logoLabelColor, for: .normal)
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.logoLabelColor.cgColor
        button.layer.borderWidth = 0.5
        return button
    }()
    
    lazy var docNameTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.docNameTextField)
        return view
    }()
    
    lazy var docDateTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.docDateTextField)
        return view
    }()
    
    lazy var docAuthorTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.docAuthorTextField)
        return view
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
        setupStyles()
        addSubviews()
        makeConstraints()
    }
    
    private func setupStyles() {
    }
    
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(achievementInfoLabel)
        containerView.addSubview(selectAchievementButton)
        containerView.addSubview(docNameTextField)
        containerView.addSubview(docDateTextField)
        containerView.addSubview(docAuthorTextField)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        selectAchievementButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(24)
            make.height.equalTo(appearance.buttonHeigh)
            make.width.equalTo(144)
        }
        achievementInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(selectAchievementButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        docNameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(achievementInfoLabel.snp.bottom).offset(4)
        }
        docDateTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(docNameTextField.snp.bottom).offset(4)
        }
        docAuthorTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalTo(docDateTextField.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension SelectedIndividualAchievementView {
    struct Appearance {
        let buttonHeigh: CGFloat = 36
        let submit = "ПРИКРЕПИТЬ"
        let achievementInfoLabel = "Допустимые форматы: .jpg, .pdf, .doc, .docx\nРазмер: не более 10Мб"
        let docNameTextField = "Наименование документа"
        let docDateTextField = "Когда выдан"
        let docAuthorTextField = "Кем выдан"
    }
}
