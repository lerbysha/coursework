//
//  StudentTextView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

public final class AbiturientTextView: UIView {
    struct Constants {
        let logoLabelColor: UIColor = UIColor(red: 0.08, green: 0.36, blue: 0.65, alpha: 1)
        let borderColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        let borderRadius: CGFloat = 8
    }
    
    private let text: String?
    private let descriptionText: String?
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
    
    lazy var inputTextView: UITextView = {
        let textField = UITextView()
        textField.textColor = .darkGray
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = constants.borderColor.cgColor
        textField.layer.cornerRadius = constants.borderRadius
        return textField
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = descriptionText
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()
    
    init(text: String? = nil, descriptionText: String? = nil) {
        self.text = text
        self.descriptionText = descriptionText
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
        contentView.addSubview(textLabel)
        contentView.addSubview(inputTextView)
        contentView.addSubview(descriptionLabel)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        inputTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(inputTextView.snp.top).offset(-8)
            make.top.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(inputTextView.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

