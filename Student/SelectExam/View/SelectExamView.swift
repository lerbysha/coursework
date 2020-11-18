//
//  SelectExamView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class SelectExamView: UIView {
    private let appearance = Appearance()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var containterView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = appearance.stackSpacing
        view.alignment = .fill
        view.distribution = .fillProportionally
        return view
    }()
    
    lazy var examView: SelectionView = {
        return SelectionView(citizenshipLabelText: appearance.exam, citizenshipPlaceholderText: appearance.exam)
    }()
    
    lazy var examTypeView: SelectionView = {
        return SelectionView(citizenshipLabelText: appearance.examType, citizenshipPlaceholderText: appearance.examType)
    }()
    
    lazy var scoreTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.score, text: appearance.score)
        view.inputTextField.keyboardType = UIKeyboardType.decimalPad
        return view
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
        setupStyles()
        addSubviews()
        makeConstraints()
    }

    private func setupStyles() {
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(containterView)
        scrollView.addSubview(submitButton)
        containterView.addArrangedSubview(examView)
        containterView.addArrangedSubview(examTypeView)
        containterView.addArrangedSubview(scoreTextField)
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.centerX.equalToSuperview()
        }
        containterView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
        }
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(containterView.snp.bottom).offset(32)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(appearance.buttonHeigh)
            make.bottom.equalToSuperview().inset(32)
        }
    }
}

extension SelectExamView {
    public struct Appearance {
        let stackSpacing: CGFloat = 16
        let buttonHeigh: CGFloat = 36
        let score = "Баллы"
        let exam = "Название экзамена"
        let examType = "Тип экзамена"
        let submit = "Сохранить"
    }
}
