// InteractiveTransition.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Анимирование перехода спомощью UIScreenEdgePanGestureRecogniser
final class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    // MARK: - Visual Components

    var viewController: UIViewController? {
        didSet {
            let recogniser = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePan))
            recogniser.edges = [.right]
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
            let relativeTranslation = translation.y / (gesture.view?.bounds.width ?? 1)
            let progress = max(0, min(1, relativeTranslation))
            shouldFinish = progress > 0.33
            update(progress)
        case .ended:
            hasStarted = false
            guard shouldFinish else {
                cancel()
                return
            }
            finish()
        case .cancelled:
            hasStarted = false
            cancel()
        default:
            return
        }
    }
}
