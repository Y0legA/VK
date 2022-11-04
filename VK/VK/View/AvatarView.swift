// AvatarView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Вью тени для аватара
final class AvatarView: UIView {
    // MARK: - Private Properties

    @IBInspectable private var shadowWidth: CGFloat = 10 {
        didSet {
            updateShadowRadius()
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowColor: UIColor = .black {
        didSet {
            updateShadowColor()
            setNeedsDisplay()
        }
    }

    @IBInspectable private var shadowOpacity: Float = 0.9 {
        didSet {
            updateShadowOpacity()
            setNeedsDisplay()
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }

    // MARK: - Private Methods

    private func configureUI() {
        setupShadow()
        updateShadowRadius()
        updateShadowColor()
        updateShadowOpacity()
    }

    private func setupShadow() {
        layer.shadowOffset = .zero
        layer.cornerRadius = bounds.width / 2
    }

    private func updateShadowRadius() {
        layer.shadowRadius = shadowWidth
    }

    private func updateShadowColor() {
        layer.shadowColor = shadowColor.cgColor
    }

    private func updateShadowOpacity() {
        layer.shadowOpacity = shadowOpacity
    }
}
