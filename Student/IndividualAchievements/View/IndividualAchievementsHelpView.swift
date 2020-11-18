//
//  IndividualAchievementsHelpView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class IndividualAchievementsHelpView: UIView {
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
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(submitButton)
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
            make.top.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
}

extension IndividualAchievementsHelpView {
    struct Appearance {
        let submit = "Понятно"
        let titleLabel = "Примечания"
        let buttonHeigh: CGFloat = 36
        let description = "Индивидуальные достижения действуют для поступающих на обучение по программам бакалавриата и специалитета.\n\nДля подтверждения индивидуального достижения поставьте галочку в соответствующую ячейку и прикрепите отсканированный вариант документа (электронный образ документа) PDF (Portable Document Files) формата, подтверждающий индивидуальное достижение, используя представленный здесь инструмент загрузки.\n\nЭлектронный образ документа должен обеспечивать визуальную идентичность его бумажному оригиналу в масштабе 1:1. Качество представленных электронных образов документов должно позволить в полном объеме прочитать текст документа и распознать его реквизиты. Если бумажный документ состоит из двух или более листов, электронный образ такого бумажного документа формируется в виде одного файла. Для сканирования документов необходимо использовать монохромный режим (черно-белый) с разрешением 300 dpi. Ограничение на размер файла 10 мб.\n\nПри отсутствии документа индивидуальное достижение не засчитывается."
    }
}

