//
//  AuthorizationView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class AuthorizationView: UIView {
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
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_launchScreen")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.logoLabel
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = appearance.logoLabelNumberOfLines
        label.textColor = .logoLabelColor
        return label
    }()
    
    lazy var emailTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.email)
        return view
    }()
    
    lazy var passwordTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.password)
        view.inputTextField.isSecureTextEntry = secureButton.isSelected
        return view
    }()
    
    private lazy var secureButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_closed_eye")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.setImage(UIImage(named: "ic_opened_eye")?.withRenderingMode(.alwaysOriginal), for: .selected)
        button.addTarget(self, action: #selector(changePasswordVisibility), for: .touchUpInside)
        button.isSelected = true
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(appearance.forgotPassword, for: .normal)
        button.setTitleColor(.logoLabelColor, for: .normal)
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        return button
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
    
//    lazy var signUpButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle(appearance.signUp, for: .normal)
//        button.setTitleColor(.logoLabelColor, for: .normal)
//        button.backgroundColor = .white
//        button.layer.masksToBounds = true
//        button.layer.cornerRadius = 8
//        button.layer.borderWidth = 1
//        button.layer.borderColor = UIColor.logoLabelColor.cgColor
//        return button
//    }()
    
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
    
    @objc
    func changePasswordVisibility() {
        secureButton.isSelected = !secureButton.isSelected
        passwordTextField.inputTextField.isSecureTextEntry = secureButton.isSelected
    }

    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(logoLabel)
        scrollView.addSubview(containterView)
        scrollView.addSubview(forgotPasswordButton)
        scrollView.addSubview(submitButton)
        //scrollView.addSubview(signUpButton)
        containterView.addArrangedSubview(emailTextField)
        containterView.addArrangedSubview(passwordTextField)
        passwordTextField.addSubview(secureButton)
    }

    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.centerX.equalToSuperview()
        }
        secureButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(122)
        }
        logoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(80)
        }
        containterView.snp.makeConstraints { make in
            make.top.equalTo(logoLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(42)
            make.centerX.equalToSuperview()
        }
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(containterView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(42)
            make.height.equalTo(appearance.buttonHeigh)
        }
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(42)
            make.height.equalTo(appearance.buttonHeigh)
        }
//        signUpButton.snp.makeConstraints { make in
//            make.top.equalTo(submitButton.snp.bottom).offset(12)
//            make.centerX.equalToSuperview()
//            make.leading.trailing.equalToSuperview().inset(42)
//            make.height.equalTo(appearance.buttonHeigh)
//            make.bottom.equalToSuperview().inset(42)
//        }
    }
}

extension AuthorizationView {
    public struct Appearance {
        let logoLabel = "Студент КФУ"
        let logoLabelNumberOfLines = 2
        let stackSpacing: CGFloat = 8
        let email = "Логин"
        let password = "Пароль"
        let forgotPassword = "Забыли пароль?"
        let submit = "ВОЙТИ"
        let signUp = "ЗАРЕГИСТРИРОВАТЬСЯ"
        let containerInset: CGFloat = 20
        let buttonHeigh: CGFloat = 36
        let buttonWidth: CGFloat = 100
    }
}
