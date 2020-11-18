//
//  ApplicationFillingTableViewCell.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class ApplicationFillingTableViewCell: UITableViewCell {
    private let appearance = Appearance()
    
    lazy var containerView: UIView = {
       let view = UIView()
       view.backgroundColor = .white
       return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var sectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .darkGray
        return label
    }()
    
    lazy var filledSectionButton: UIButton = {
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
//        selectionStyle = .none
        backgroundColor = .white
        setupStyles()
        addSubviews()
        makeConstraints()
    }

    private func setupStyles() {
        filledSectionButton.setImage(UIImage(named: "ic_filledField"), for: .selected)
        filledSectionButton.setImage(UIImage(named: "ic_unfilledField"), for: .normal)
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(sectionLabel)
        containerView.addSubview(filledSectionButton)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(42)
        }
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(4)
            make.trailing.equalTo(sectionLabel.snp.leading).offset(-8)
            make.width.height.equalTo(24)
        }
        filledSectionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerX.equalTo(iconImageView)
            make.top.bottom.equalToSuperview().inset(4)
            make.height.width.equalTo(24)
        }
        sectionLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.trailing.equalTo(filledSectionButton.snp.leading).offset(-8)
        }
    }
    
}

extension ApplicationFillingTableViewCell {
    struct Appearance {
    }
}
