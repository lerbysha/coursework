//
//  SelectionView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class SelectionView: UIView {
    struct Constants {
    }
    
    private let citizenshipLabelText: String
    private let citizenshipPlaceholderText: String?
    private let constants = Constants()
    
    lazy var citizenshipLabel: UILabel = {
        let label = UILabel()
        label.text = citizenshipLabelText
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .logoLabelColor
        return label
    }()
    
    lazy var citizenshipView: UIView = {
        return UIView()
    }()
    
    lazy var citizenshipRoundedView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor.borderColor.cgColor
        view.layer.borderWidth = 0.5
        view.backgroundColor = .white
        return view
    }()
    
    lazy var citizenshipPlaceholder: UILabel = {
        let label = UILabel()
        label.text = citizenshipPlaceholderText
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var arrowDownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_arrowDown")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    init(citizenshipLabelText: String, citizenshipPlaceholderText: String? = nil) {
        self.citizenshipLabelText = citizenshipLabelText
        self.citizenshipPlaceholderText = citizenshipPlaceholderText
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setPlaceholderText(text: String) {
        citizenshipPlaceholder.text = text
    }
    
    private func commonInit() {
        addSubviews()
        makeConstraints()
    }
    
    private func addSubviews() {
        addSubview(citizenshipView)
        citizenshipView.addSubview(citizenshipRoundedView)
        citizenshipView.addSubview(citizenshipLabel)
        citizenshipRoundedView.addSubview(citizenshipPlaceholder)
        citizenshipRoundedView.addSubview(arrowDownImageView)
    }
    
    private func makeConstraints() {
        citizenshipView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        citizenshipRoundedView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        citizenshipLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalTo(citizenshipRoundedView.snp.top).offset(-8)
        }
        citizenshipPlaceholder.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
        arrowDownImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(16)
        }
    }
}
