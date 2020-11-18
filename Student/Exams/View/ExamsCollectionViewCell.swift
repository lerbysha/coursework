//
//  ExamsCollectionViewCell.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class ExamsCollectionViewCell: UICollectionViewCell {
    private let appearance = Appearance()
    
    lazy var containerView: UIView = {
       let view = UIView()
       view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
       return view
    }()
    
    lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .darkGray
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        notesLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }

    private func commonInit() {
        setupStyles()
        addSubviews()
        makeConstraints()
    }

    private func setupStyles() {
        backgroundColor = .white
        containerView.backgroundColor = appearance.backgroundColor
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(notesLabel)
    }
    
    private func makeConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview()
        }
        notesLabel.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(8)
        }
    }
    
}

extension ExamsCollectionViewCell {
    struct Appearance {
        let backgroundColor = UIColor(red: 1, green: 0.961, blue: 0.616, alpha: 1)
    }
}
