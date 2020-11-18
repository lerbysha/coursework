//
//  SchoolsView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class SchoolsView: UIView {
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
    
    lazy var typeOfSchoolView: SelectionView = {
        return SelectionView(citizenshipLabelText: appearance.typeOfSchool, citizenshipPlaceholderText: appearance.typeOfSchool)
    }()
    
    lazy var lastYearTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.lastYear, text: appearance.lastYear)
        view.inputTextField.keyboardType = UIKeyboardType.decimalPad
        return view
    }()
    
    lazy var typeOfEducationView: SelectionView = {
        return SelectionView(citizenshipLabelText: appearance.typeOfEducation, citizenshipPlaceholderText: appearance.typeOfEducation)
    }()
    
    lazy var nameOfSchoolTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.nameOfSchool, text: appearance.nameOfSchool, forRussiansText: appearance.additionalInformation)
        return view
    }()
    
    lazy var certificateSeriesTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.certificateSeries, text: appearance.certificateSeries, forRussiansText: appearance.optionalАield)
        return view
    }()
    
    lazy var certificateNumberView: TextFieldView = {
        return TextFieldView(name: appearance.certificateNumber, text: appearance.certificateNumber)
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
        containterView.addArrangedSubview(typeOfSchoolView)
        containterView.addArrangedSubview(lastYearTextField)
        containterView.addArrangedSubview(typeOfEducationView)
        containterView.addArrangedSubview(nameOfSchoolTextField)
        containterView.addArrangedSubview(certificateSeriesTextField)
        containterView.addArrangedSubview(certificateNumberView)
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
            make.top.greaterThanOrEqualTo(containterView.snp.bottom).offset(32).priority(250)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(appearance.buttonHeigh)
            make.bottom.equalToSuperview().inset(32)
        }
    }
}

extension SchoolsView {
    public struct Appearance {
        let stackSpacing: CGFloat = 16
        let typeOfSchool = "Тип учебного заведения"
        let lastYear = "Год окончания учебного заведения"
        let typeOfEducation = "Полученное образование"
        let nameOfSchool = "Оконченное учебное заведение"
        let additionalInformation = "При отсуствии в списке ввести как в аттестате (дипломе)"
        let certificateSeries = "Серия аттестата (диплома)"
        let optionalАield = "Необязательно для заполнения"
        let certificateNumber = "Номер аттестата (диплома)"
        let submit = "Сохранить"
        let buttonHeigh: CGFloat = 36
    }
}
