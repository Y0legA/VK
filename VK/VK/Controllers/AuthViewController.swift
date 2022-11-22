// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Временный экран авторизации
final class AuthViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let segueIdentifier = "enterSegue"
        static let alertTitleText = "Ошибка"
        static let alertMessageText = "Введены неверные данные пользователя"
        static let alertOkText = "OK"
        static let login = "a"
        static let password = "1"
        static let emptyString = ""
        static let opacity = "opacity"
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

    @IBOutlet private var uploadIndicatorView: UIView!
    @IBOutlet private var firstCircleUploadView: UIView!
    @IBOutlet private var secondCircleUploadView: UIView!
    @IBOutlet private var thirdCircleUploadView: UIView!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }

    // MARK: - Private IBAction

    @IBAction private func goTabBarAction(_ sender: Any) {
        if checkLogin() {
            startUploadIndicator()
            clearTextFields()
            DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
                self.performSegue(withIdentifier: Constants.segueIdentifier, sender: self)
            }
        } else {
            clearTextFields()
            showAlert(
                title: Constants.alertTitleText,
                message: Constants.alertMessageText,
                actionTitle: Constants.alertOkText,
                handler: nil
            )
        }
    }

    // MARK: - Private Methods

    @objc private func keyboardWillShownAction(_ notification: Notification) {
        let info = notification.userInfo as? NSDictionary
        let kbSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue)?.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize?.height ?? 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHideAction(_ notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }

    @objc private func hideKeyboardAction() {
        scrollView.endEditing(true)
    }

    private func startUploadIndicator() {
        let group = CAAnimationGroup()
        let firstAnimation = setAnimation(firstCircleUploadView, 1)
        let secondAnimation = setAnimation(secondCircleUploadView, 3)
        let thirdAnimation = setAnimation(thirdCircleUploadView, 5)
        group.animations = [firstAnimation, secondAnimation, thirdAnimation]
        firstCircleUploadView.layer.add(firstAnimation, forKey: nil)
        secondCircleUploadView.layer.add(secondAnimation, forKey: nil)
        thirdCircleUploadView.layer.add(thirdAnimation, forKey: nil)
    }

    private func setAnimation(_ view: UIView, _ delay: Double) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: Constants.opacity)
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + delay
        animation.fillMode = .backwards
        view.alpha = 1
        return animation
    }

    private func checkLogin() -> Bool {
        let loginText = loginTextField.text ?? Constants.emptyString
        let passwordText = passwordTextField.text ?? Constants.emptyString
        if loginText == Constants.login, passwordText == Constants.password {
            return true
        } else {
            return false
        }
    }

    private func configureUI() {
        configureScrollView()
        setPaddingTextfields()
    }

    private func setPaddingTextfields() {
        loginTextField.setWallsPaddingPoints(10)
        passwordTextField.setWallsPaddingPoints(10)
    }

    private func clearTextFields() {
        loginTextField.text = Constants.emptyString
        passwordTextField.text = Constants.emptyString
    }

    private func configureScrollView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardAction))
        scrollView.addGestureRecognizer(tapGesture)
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShownAction),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideAction),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
