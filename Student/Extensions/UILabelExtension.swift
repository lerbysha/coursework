//
//  UILabelExtension.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(
        text: String? = nil,
        font: UIFont = .systemFont(ofSize: UIFont.labelFontSize),
        textColor: UIColor = .black,
        textAlignment: NSTextAlignment = .left,
        numberOfLines: Int = 1,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail,
        backgroundColor: UIColor = .clear,
        adjustsFontSizeToFitWidth: Bool = false
    ) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.backgroundColor = backgroundColor
        self.lineBreakMode = lineBreakMode
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
    }
}
