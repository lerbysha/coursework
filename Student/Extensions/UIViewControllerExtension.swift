//
//  UIViewControllerExtension.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func showLoader(style: UIActivityIndicatorView.Style = .whiteLarge) {
        guard subviews.contains(where: { $0 is UIActivityIndicatorView }) == false else { return }

        let loader = UIActivityIndicatorView(frame: CGRect(x: .zero, y: .zero, width: frame.width, height: frame.height))
        loader.style = style
        loader.color = .gray
        loader.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        loader.startAnimating()
        loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(loader)
    }

    func hideLoader() {
        if let loader = subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
            loader.startAnimating()
            loader.removeFromSuperview()
        }
    }
}
