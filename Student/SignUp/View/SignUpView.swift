//
//  SignUpView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class SignUpView: UIView {
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
        view.distribution = .fillEqually
        return view
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
    
    lazy var emailTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.email, text: appearance.email)
        return view
    }()
    
    lazy var passwordTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.password, text: appearance.password)
        return view
    }()
    
    lazy var repeatPasswordTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.repeatPassword, text: appearance.repeatPassword)
        return view
    }()
    
    lazy var checkbox: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    lazy var processingPersonalDataLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.processingPersonalDataLabel
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var processingPersonalDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(appearance.processingPersonalDataButton, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        button.setTitleColor(.logoLabelColor, for: .normal)
        return button
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(appearance.submit, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.isEnabled = false
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
        checkbox.isSelected = false
        checkbox.setImage(UIImage(named: "ic_checkbox"), for: .normal)
        checkbox.setImage(UIImage(named: "ic_selectedCheckbox"), for: .selected)
        setupStyles()
        addSubviews()
        makeConstraints()
        checkbox.addTarget(self, action: #selector(checkboxTapped), for: .touchUpInside)
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
    
    @objc
    func checkboxTapped() {
        checkbox.isSelected = !checkbox.isSelected
        submitButton.isEnabled = checkbox.isSelected
        submitButton.backgroundColor = checkbox.isSelected ? .logoLabelColor : .lightGray
    }

    private func setupStyles() {
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(containterView)
        containterView.addArrangedSubview(lastNameTextField)
        containterView.addArrangedSubview(firstNameTextField)
        containterView.addArrangedSubview(secondNameTextField)
        containterView.addArrangedSubview(emailTextField)
        containterView.addArrangedSubview(passwordTextField)
        containterView.addArrangedSubview(repeatPasswordTextField)
        scrollView.addSubview(submitButton)
        scrollView.addSubview(checkbox)
        scrollView.addSubview(processingPersonalDataLabel)
        scrollView.addSubview(processingPersonalDataButton)
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containterView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(42)
        }
        submitButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(32)
            make.top.equalTo(checkbox.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(appearance.buttonHeigh)
        }
        checkbox.snp.makeConstraints { make in
            make.top.equalTo(containterView.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(24)
            make.height.width.equalTo(18)
        }
        processingPersonalDataLabel.snp.makeConstraints { make in
            make.top.equalTo(checkbox.snp.top)
            make.leading.equalTo(checkbox.snp.trailing).offset(8)
        }
        processingPersonalDataButton.snp.makeConstraints { make in
            make.leading.equalTo(checkbox.snp.trailing).offset(8)
            make.top.equalTo(processingPersonalDataLabel.snp.bottom)
        }
    }
}

extension SignUpView {
    struct Appearance {
        let stackSpacing: CGFloat = 16
        let lastName = "Фамилия"
        let firstName = "Имя"
        let secondName = "Отчество"
        let email = "Email"
        let password = "Пароль"
        let repeatPassword = "Повторите пароль"
        let submit = "Подтвердить"
        let processingPersonalDataLabel = "Согласие на обработку персональных данных."
        let processingPersonalDataButton = "Подробнее здесь"
        let buttonHeigh: CGFloat = 36
    }
}
