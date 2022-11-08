// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран авторизации
final class AuthViewController: UIViewController {
    // MARK: - Private Constants

    private enum Constants {
        static let segueIdentifier = "enterSegue"
        static let alertTitleText = "Ошибка"
        static let alertMessageText = "Введены неверные данные пользователя"
        static let alertOkText = "OK"
        static let login = "admin"
        static let password = "12345"
        static let emptyString = ""
    }

    // MARK: - Private IBOutlet

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!

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

    // MARK: - Public Methods

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if checkLogin() {
            clearTextFields()
            return true
        } else {
            clearTextFields()
            showAlert(
                title: Constants.alertTitleText,
                message: Constants.alertMessageText,
                actionTitle: Constants.alertOkText,
                handler: nil
            )
            return false
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

    private func checkLogin() -> Bool {
        let loginText = loginTextField.text ?? Constants.emptyString
        let passwordText = passwordTextField.text ?? Constants.emptyString
        if loginText == Constants.login, passwordText == Constants.password {
            return true
        } else {
            return true
//            return false
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
