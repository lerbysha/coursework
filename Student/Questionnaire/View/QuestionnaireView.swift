//
//  QuestionnaireView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class QuestionnaireView: UIView {
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
    
    lazy var firstSectionLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.mainInfo
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var lastNameTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.lastName, text: appearance.lastName)
        return view
    }()
    
    lazy var firstNameTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.firstName, text: appearance.firstName)
        return view
    }()
    
    lazy var secondNameTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.secondName, text: appearance.secondName)
        return view
    }()
    
    lazy var birthdateTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.birthdatePlaceholder, text: appearance.birthdate)
        return view
    }()
    
    lazy var sexView: UIView = {
        return UIView()
    }()
    
    lazy var sexLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.sexLabel
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .logoLabelColor
        return label
    }()
    
    lazy var maleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_unselectedSelection")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setImage(UIImage(named: "ic_selectedSelection")?.withRenderingMode(.alwaysOriginal), for: .selected)
        button.setTitle(appearance.maleButtonText, for: .normal)
        button.tintColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.titleLabel?.adjustsFontSizeToFitWidth = false
        button.setTitleColor(.darkGray, for: .normal)
        button.titleEdgeInsets.left = 8
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    lazy var femaleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_unselectedSelection")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setImage(UIImage(named: "ic_selectedSelection")?.withRenderingMode(.alwaysOriginal), for: .selected)
        button.tintColor = .darkGray
        button.setTitle(appearance.femaleButtonText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.titleLabel?.adjustsFontSizeToFitWidth = false
        button.setTitleColor(.darkGray, for: .normal)
        button.titleEdgeInsets.left = 8
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    lazy var phoneNumberTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.phoneNumber, text: appearance.phoneNumber)
        return view
    }()
    
    lazy var citizenshipView: SelectionView = {
        return SelectionView(citizenshipLabelText: appearance.citizenshipLabel, citizenshipPlaceholderText: appearance.citizenshipLabel)
    }()
    
    lazy var secondSectionLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.secondInfo
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var documentView: SelectionView = {
        return SelectionView(citizenshipLabelText: appearance.documentLabel, citizenshipPlaceholderText: appearance.documentLabel)
    }()
    
    lazy var shortNumberTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.shortNumber, text: appearance.shortNumber)
        return view
    }()
    
    lazy var longNumberTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.longNumber, text: appearance.longNumber)
        return view
    }()
    
    lazy var dateOfGettingTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.dateOfGettingPlaceholder, text: appearance.dateOfGetting)
        return view
    }()
    
    lazy var givenByWhomTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.givenByWhomPlaceholder, text: appearance.givenByWhom)
        return view
    }()
    
    lazy var codeTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.code, text: appearance.code)
        return view
    }()
    
    lazy var innNumberTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.innNumber, text: appearance.innNumber, forRussiansText: appearance.forRussiansText)
        return view
    }()
    
    lazy var insuranceTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.insurance, text: appearance.insurance, forRussiansText: appearance.forRussiansText)
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
        addTapGesture()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onShowKeyboard(notification:)),
            name: UIWindow.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(onHideKeyboard),
            name: UIWindow.keyboardWillHideNotification,
            object: nil
        )
    }

    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        addGestureRecognizer(tapGesture)
    }

    @objc
    private func onShowKeyboard(notification: Notification) {
        guard let keyboardFrameValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = convert(keyboardFrameValue.cgRectValue, from: nil)
        scrollView.contentInset.bottom = keyboardFrame.size.height
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }

    @objc
    private func onHideKeyboard() {
        scrollView.contentInset = .zero
    }

    @objc
    private func hideKeyboard() {
        endEditing(true)
    }

    private func setupStyles() {
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(containterView)
        scrollView.addSubview(submitButton)
        containterView.addArrangedSubview(firstSectionLabel)
        containterView.addArrangedSubview(lastNameTextField)
        containterView.addArrangedSubview(firstNameTextField)
        containterView.addArrangedSubview(secondNameTextField)
        containterView.addArrangedSubview(birthdateTextField)
        containterView.addArrangedSubview(sexView)
        containterView.addArrangedSubview(phoneNumberTextField)
        containterView.addArrangedSubview(citizenshipView)
        sexView.addSubview(sexLabel)
        sexView.addSubview(maleButton)
        sexView.addSubview(femaleButton)
        containterView.addArrangedSubview(secondSectionLabel)
        containterView.addArrangedSubview(documentView)
        containterView.addArrangedSubview(shortNumberTextField)
        containterView.addArrangedSubview(longNumberTextField)
        containterView.addArrangedSubview(dateOfGettingTextField)
        containterView.addArrangedSubview(givenByWhomTextField)
        containterView.addArrangedSubview(codeTextField)
        containterView.addArrangedSubview(innNumberTextField)
        containterView.addArrangedSubview(insuranceTextField)
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
        sexLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        maleButton.snp.makeConstraints { make in
            make.top.equalTo(sexLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        femaleButton.snp.makeConstraints { make in
            make.top.equalTo(maleButton.snp.bottom).offset(12)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
}

extension QuestionnaireView {
    public struct Appearance {
        let lastName = "Фамилия"
        let firstName = "Имя"
        let secondName = "Отчество"
        let birthdate = "Дата рождения"
        let birthdatePlaceholder = "Дата рождения (дд.мм.гггг)"
        let sexLabel = "Пол"
        let maleButtonText = "Мужской"
        let femaleButtonText = "Женский"
        let phoneNumber = "Телефон"
        let citizenshipLabel = "Гражданство"
        let stackSpacing: CGFloat = 16
        let submit = "Сохранить"
        let containerInset: CGFloat = 20
        let buttonHeigh: CGFloat = 36
        let buttonWidth: CGFloat = 100
        let mainInfo = "Общие сведения"
        let secondInfo = "Документ, удостоверяющий личность"
        let documentLabel = "Тип документа"
        let shortNumber = "Серия документа"
        let longNumber = "Номер документа"
        let innNumber = "ИНН"
        let insurance = "Страховое свидетельство"
        let dateOfGetting = "Когда выдан"
        let dateOfGettingPlaceholder = "Когда выдан (дд.мм.гггг)"
        let givenByWhom = "Кем выдан"
        let givenByWhomPlaceholder = "Заполнять как в паспорте, без сокращений"
        let forRussiansText = "Доп. документы (для граждан РФ)"
        let code = "Код подразделения"
    }
}
