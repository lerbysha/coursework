//
//  AdditionalInformationView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class AdditionalInformationView: UIView {
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
    
    lazy var hostelView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var hostelLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.hostelText
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var checkbox: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ic_checkbox"), for: .normal)
        button.setImage(UIImage(named: "ic_selectedCheckbox"), for: .selected)
        return button
    }()
    
    lazy var languageTextField: TextFieldView = {
        let view = TextFieldView(name: appearance.language, text: appearance.language)
        return view
    }()
    
    lazy var fatherTextView: AbiturientTextView = {
        let textView = AbiturientTextView(text: appearance.father, descriptionText: appearance.fatherDescription)
        return textView
    }()
    
    lazy var motherTextView: AbiturientTextView = {
        let textView = AbiturientTextView(text: appearance.mother, descriptionText: appearance.motherDescription)
        return textView
    }()
    
    lazy var aboutMeTextView: AbiturientTextView = {
        let textView = AbiturientTextView(text: appearance.aboutMe)
        return textView
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
        hostelView.addSubview(hostelLabel)
        hostelView.addSubview(checkbox)
        containterView.addArrangedSubview(hostelView)
        containterView.addArrangedSubview(languageTextField)
        containterView.addArrangedSubview(fatherTextView)
        containterView.addArrangedSubview(motherTextView)
        containterView.addArrangedSubview(aboutMeTextView)
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.centerX.equalToSuperview()
        }
        containterView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.trailing.equalToSuperview().inset(appearance.mSpace)
            make.centerX.equalToSuperview()
        }
        checkbox.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.height.width.equalTo(appearance.mSpace)
        }
        hostelLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(checkbox.snp.leading)
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

extension AdditionalInformationView {
    public struct Appearance {
        let stackSpacing: CGFloat = 16
        let hostelText = "Требуется общежитие"
        let language = "Желаемый для изучения иностранный язык"
        let targetDirection = "Целевое направления"
        let contractNumber = "Номер договора"
        let contractDate = "Дата договора"
        let directingOrganization = "Направляющая организация"
        let parentsInfo = "Информация о родителях"
        let father = "Отец"
        let fatherDescription = "Пример: Сайков Иван Петрович, старший инженер завода \"Радиоприбор\", г.Казань, +7(ххх)ххх-хх-хх"
        let mother = "Мать"
        let motherDescription = "Пример: Гарифовна Сара Садыкова, солистка Татарского театра оперы и балета, г.Казань, +7(ххх)ххх-хх-хх"
        let aboutMe = "О себе"
        let submit = "Сохранить"
        let mSpace = 24
        let buttonHeigh: CGFloat = 36
    }
}
