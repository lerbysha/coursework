//
//  ApplicationFillingHelpView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class ApplicationFillingHelpView: UIView {
    private let appearance = Appearance()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.titleLabel
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .logoLabelColor
        label.numberOfLines = 0
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "ic_appFilling")
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.description
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
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
        scrollView.addSubview(submitButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(imageView)
        scrollView.addSubview(descriptionLabel)
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.centerX.equalToSuperview()
        }
        submitButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(appearance.buttonHeigh)
            make.bottom.equalToSuperview().inset(32)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(24)
            make.top.equalToSuperview().inset(32)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
            make.width.equalTo(imageView.snp.height)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

extension ApplicationFillingHelpView {
    struct Appearance {
        let submit = "Понятно"
        let buttonHeigh: CGFloat = 36
        let titleLabel = "Процедура\nподачи заявления"
        let description = "Перед тем как подать заявление, вам предстоит заполнить несколько информационных блоков о себе.\nБлоки можно заполнять в любое удобное для вас время.\nТолько после заполнения всех блоков, вам станет доступна опция “Подачи заявления”."
    }
}
