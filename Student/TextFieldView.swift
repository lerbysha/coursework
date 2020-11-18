//
//  TextFieldView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public final class TextFieldView: UIView {
    struct Constants {
        let xxxsSpace: CGFloat = 4
        let xxsSpace: CGFloat = 8
        let xxlSpace: CGFloat = 48
        let borderColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        let logoLabelColor: UIColor = UIColor(red: 0.08, green: 0.36, blue: 0.65, alpha: 1)
    }
    
    private let name: String
    private let text: String?
    private let forRussiansText: String?
    private let constants = Constants()
    
    lazy var contentView: UIView = {
        return UIView()
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = constants.logoLabelColor
        return label
    }()
    
    lazy var roundedView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = constants.xxsSpace
        view.layer.borderColor = constants.borderColor.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = .white
        return view
    }()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = name
        textField.backgroundColor = .clear
        textField.textColor = .darkGray
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    lazy var forRussiansLabel: UILabel = {
        let label = UILabel()
        label.text = forRussiansText
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    init(name: String, text: String? = nil, forRussiansText: String? = nil) {
        self.name = name
        self.text = text
        self.forRussiansText = forRussiansText
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        addSubview(contentView)
        contentView.addSubview(roundedView)
        roundedView.addSubview(inputTextField)
        contentView.addSubview(textLabel)
        contentView.addSubview(forRussiansLabel)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        roundedView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(constants.xxlSpace)
        }
        inputTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(constants.xxsSpace)
            make.top.bottom.trailing.equalToSuperview()
        }
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(roundedView)
            make.bottom.equalTo(roundedView.snp.top).offset(-8)
            make.top.equalToSuperview()
        }
        forRussiansLabel.snp.makeConstraints { make in
            make.top.equalTo(roundedView.snp.bottom).offset(4)
            make.leading.bottom.equalToSuperview()
        }
    }
}
