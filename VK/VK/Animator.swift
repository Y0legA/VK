// Animator.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// MARK: - Private Constants

private enum Constants {
    static let rotationZ = "transform.rotation.z"
    static let rotationAnimation = "rotationAnimation"
}

// класс для анимирования перехода на другой экран вперед
final class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
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

// класс для анимирования перехода на другой экран назад
final class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    // MARK: - Public Methods

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        1.0
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let source = transitionContext.viewController(forKey: .from),
              let destination = transitionContext.viewController(forKey: .to) else { return }
        let width = source.view.bounds.width
        let height = source.view.bounds.height
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        destination.view.transform = CGAffineTransform(translationX: 2 * width, y: 0)
            .concatenating(CGAffineTransform(scaleX: 0.8, y: 0.8))
            .concatenating(CGAffineTransform(rotationAngle: .pi / -2))
        destination.view.center = CGPoint(x: width, y: source.view.center.y)
        UIView.animateKeyframes(
            withDuration: 0.5,
            delay: 0,
            options: .calculationModePaced
        ) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                let translation = CGAffineTransform(translationX: -width, y: 0)
                let rotation = CGAffineTransform(rotationAngle: .pi / 2)
                source.view.center = CGPoint(x: width + height / 2, y: width / 2)
                source.view.transform = translation.concatenating(rotation)
            }

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                destination.view.transform = .identity
            }
        } completion: { finished in
            if finished, !transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
                transitionContext.completeTransition(true)
            } else {
                transitionContext.completeTransition(false)
            }
        }
    }
}

// класс для анимирования перехода спомощью UIScreenEdgePanGestureRacogniser
final class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Visual Components

    var viewController: UIViewController? {
        didSet {
            let recogniser = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePan))
            recogniser.edges = [.left]
            viewController?.view.addGestureRecognizer(recogniser)
        }
    }

    // MARK: - Public Properties

    var hasStarted = false
    var shouldFinish = false

    // MARK: - Public Actions

    @objc private func handlePan(_ gesture: UIScreenEdgePanGestureRecognizer) {
        switch gesture.state {
        case .began:
            hasStarted = true
            viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = gesture.translation(in: gesture.view)
            let relativeTranslation = translation.x / (gesture.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            shouldFinish = progress > 0.33
            update(progress)
        case .ended:
            hasStarted = false
            shouldFinish ? finish() : cancel()
        case .cancelled:
            hasStarted = false
            cancel()
        default:
            return
        }
    }
}
