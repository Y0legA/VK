// AuthViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// Экран авторизации
final class AuthViewController: UIViewController {
    private enum Constants {
        static let segue = "enterSegue"
        static let mistake = "Ошибка"
        static let enteredDataText = "Введены неверные данные пользователя"
        static let okText = "OK"
        static let login = "admin"
        static let password = "12345"
    }

    // MARK: - Private IBoutlet

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!

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
    
    //MARK: - Navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if checkLogin() {
            clearTextFields()
            return true
        } else {
            clearTextFields()
            createAlertController()
            return false
        }
    }

    // MARK: - Private IBAction

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

    // MARK: - Private Methods

    private func createAlertController() {
        let alertController = UIAlertController(
            title: Constants.mistake,
            message: Constants.enteredDataText,
            preferredStyle: .alert
        )
        let alertControllerAction = UIAlertAction(title: Constants.okText, style: .cancel, handler: nil)
        alertController.addAction(alertControllerAction)
        present(alertController, animated: true, completion: nil)
    }

    private func checkLogin() -> Bool {
        let loginText = loginTextField.text ?? String()
        let pwdText = passwordTextField.text ?? String()
        if loginText == Constants.login, pwdText == Constants.password {
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
        loginTextField.setWallsPadingPoints(10)
        passwordTextField.setWallsPadingPoints(10)
    }

    private func clearTextFields() {
        loginTextField.text = String()
        passwordTextField.text = String()
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
