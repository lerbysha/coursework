//
//  ExamsTableViewCell.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class ExamsTableViewCell: UITableViewCell {
    private let appearance = Appearance()
    
    lazy var containerView: UIView = {
       let view = UIView()
       view.backgroundColor = .white
       return view
    }()
    
    lazy var examNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var examScoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var deleteExamButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    lazy var editExamButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        selectionStyle = .none
        backgroundColor = .white
        setupStyles()
        addSubviews()
        makeConstraints()
    }

    private func setupStyles() {
        deleteExamButton.setImage(UIImage(named: "ic_deleteButton"), for: .normal)
        editExamButton.setImage(UIImage(named: "ic_editButton"), for: .normal)
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(examNameLabel)
        containerView.addSubview(examScoreLabel)
        containerView.addSubview(editExamButton)
        containerView.addSubview(deleteExamButton)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview()
        }
        deleteExamButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview().inset(8)
            make.height.width.equalTo(24)
        }
        editExamButton.snp.makeConstraints { make in
            make.trailing.equalTo(deleteExamButton.snp.leading).offset(-8)
            make.top.bottom.equalToSuperview().inset(8)
            make.height.width.equalTo(24)
        }
        examScoreLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(editExamButton.snp.leading).offset(-8)
        }
        examNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(examScoreLabel.snp.leading).offset(-8)
        }
    }
    
}

extension ExamsTableViewCell {
    struct Appearance {
    }
}
