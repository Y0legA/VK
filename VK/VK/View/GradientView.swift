// GradientView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Вью для задания градиента
@IBDesignable final class GradientView: UIView {
    // MARK: - Public Properties

    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    // MARK: - Private Properties

    private var gradientLayer: CAGradientLayer {
        layer as? CAGradientLayer ?? CAGradientLayer()
    }

    @IBInspectable private var startColor: UIColor = .white {
        didSet {
            updateColors()
        }
    }

    @IBInspectable private var endColor: UIColor = .black {
        didSet {
            updateColors()
        }
    }

    @IBInspectable private var startLocation: CGFloat = 0 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable private var endLocation: CGFloat = 1 {
        didSet {
            updateLocations()
        }
    }

    @IBInspectable private var startPoint: CGPoint = .zero {
        didSet {
            updateStartPoint()
        }
    }

    @IBInspectable private var endPoint: CGPoint = .init(x: 1, y: 1) {
        didSet {
            updateEndPoint()
        }
    }

    // MARK: - Private Methods

    private func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }

    private func updateStartPoint() {
        gradientLayer.startPoint = startPoint
    }

    private func updateEndPoint() {
        gradientLayer.endPoint = endPoint
    }

    private func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
}
