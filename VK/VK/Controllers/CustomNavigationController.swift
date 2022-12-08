// CustomNavigationController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран кастомного навигейшн контроллера
final class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    // MARK: - Private Visual Components

    private let interactiveTransition = InteractiveTransition()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Public Methods

    func navigationController(
        _ navigationController: UINavigationController,
        interactionControllerFor animationController: UIViewControllerAnimatedTransitioning
    ) -> UIViewControllerInteractiveTransitioning? {
        interactiveTransition.hasStarted ? interactiveTransition : nil
    }

    func navigationController(
        _ navigationController: UINavigationController,
        animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            interactiveTransition.viewController = toVC
            return PushAnimator()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
            }
            return PopAnimator()
        }
        return nil
    }

    // MARK: - Private Methods

    private func configureUI() {
        delegate = self
    }
}
