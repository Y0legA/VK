// PushAnimator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Анимирование перехода на другой экран вперед
final class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Private Constants

    private enum Constants {
        static let rotationZ = "transform.rotation.z"
        static let rotationAnimation = "rotationAnimation"
    }

    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourceVC = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }

        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = sourceVC.view.frame
        destination.view.layer.add(rotation(), forKey: Constants.rotationAnimation)
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        UIView.animateKeyframes(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                destination.view.transform = .identity
            }
        ) { result in
            if result, !transitionContext.transitionWasCancelled {
                sourceVC.view.transform = .identity
                transitionContext.completeTransition(true)
            } else {
                transitionContext.completeTransition(false)
            }
        }
    }

    // MARK: - Private Methods

    private func rotation() -> CABasicAnimation {
        let rotation = CABasicAnimation(keyPath: Constants.rotationZ)
        rotation.fromValue = Float.pi / 2
        rotation.toValue = 0
        rotation.duration = 0.5
        return rotation
    }
}
