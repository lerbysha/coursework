//
//  FloatingPanelBuilder.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import FloatingPanel

class FloatingPanelBulder {
    enum Constants {
        static let cornerRadiusKey = "cornerRadius"
        static let grabberViewAlpha: CGFloat = 0.1
    }

    private var cornerRadius: CGFloat = 8
    private var shadowHidden: Bool = false
    private var isRemovalInteractionEnabled: Bool = true
    private var grabberHandleWidth: CGFloat = 63
    private var grabberHandleHeight: CGFloat = 4
    private var grabberTopPadding: CGFloat = 7

    func build(
        contentVC: UIViewController,
        positions: [FloatingPanelPosition] = [.full, .hidden],
        startPosition: FloatingPanelPosition = .full,
        fullInset: CGFloat = 18,
        halfInset: CGFloat = 0,
        tipInset: CGFloat = 0
    ) -> CustomFloatingPanelController {
        let floatingPanel = CustomFloatingPanelController()

        let delegate = FloatingParametrPickerConfiguration.shared
        delegate.layout.positions = positions
        delegate.layout.startPosition = startPosition
        delegate.layout.fullInset = fullInset
        delegate.layout.halfInset = halfInset
        delegate.layout.tipInset = tipInset

        floatingPanel.delegate = delegate
        floatingPanel.surfaceView.setValue(cornerRadius, forKey: Constants.cornerRadiusKey)
        floatingPanel.surfaceView.shadowHidden = shadowHidden
        floatingPanel.isRemovalInteractionEnabled = isRemovalInteractionEnabled
        floatingPanel.set(contentViewController: contentVC)
        floatingPanel.surfaceView.grabberHandle.barColor = .black
        floatingPanel.surfaceView.grabberHandle.alpha = Constants.grabberViewAlpha
        floatingPanel.surfaceView.grabberHandleWidth = grabberHandleWidth
        floatingPanel.surfaceView.grabberHandleHeight = grabberHandleHeight
        floatingPanel.surfaceView.grabberTopPadding = grabberTopPadding

        if let scrollView = contentVC.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView {
            floatingPanel.track(scrollView: scrollView)
            floatingPanel.contentInsetAdjustmentBehavior = .never
        }
        return floatingPanel
    }
}

class CustomFloatingPanelController: FloatingPanelController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGradientLayer()
    }

    private func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        backdropView.backgroundColor = .clear
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.logoLabelColor.cgColor,
            UIColor.clear.cgColor,
        ]
        backdropView.layer.addSublayer(gradientLayer)
    }
}

class FloatingParametrPickerConfiguration: FloatingPanelControllerDelegate {
    static let shared = FloatingParametrPickerConfiguration()

    var layout: FloatingCustomLayout = ModalPanelLayout()

    // if it returns nil, FloatingPanelController uses the default layout
    func floatingPanel(
        _ vc: FloatingPanelController,
        layoutFor newCollection: UITraitCollection
    ) -> FloatingPanelLayout? {
        return layout
    }

    func floatingPanelDidMove(_ vc: FloatingPanelController) {
        vc.view.endEditing(true)
    }
}

protocol FloatingCustomLayout: FloatingPanelLayout {
    var fullInset: CGFloat { get set }
    var halfInset: CGFloat { get set }
    var tipInset: CGFloat { get set }
    var positions: [FloatingPanelPosition] { get set }
    var startPosition: FloatingPanelPosition { get set }
}

class ModalPanelLayout: FloatingCustomLayout {
    var fullInset: CGFloat = 18.0
    var halfInset: CGFloat = 0
    var tipInset: CGFloat = 0

    var positions: [FloatingPanelPosition] = [.full, .hidden]
    var startPosition: FloatingPanelPosition = .full

    var supportedPositions: Set<FloatingPanelPosition> {
        return Set(positions)
    }

    public var initialPosition: FloatingPanelPosition {
        return .full
    }

    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return fullInset
        case .half: return halfInset
        case .tip: return tipInset
        case .hidden: return nil
        }
    }

    public func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
        return 0.95
    }
}

