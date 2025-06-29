//
//  Task3ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit
import Combine

// Lay out login screen as in the attached screen recording.
// 1. Content should respect safe area guides
// 2. Content should be visible on all screen sizes
// 3. Content should be spaced on bottom as in the recording
// 4. When keyboard appears, content should move up
// 5. When you tap the screen and keyboard gets dismissed, content should move down
// 6. You can use container views/layout guides or any option you find useful
// 7. Content should have horizontal spacing of 16
// 8. Title and description labels should have a vertical spacing of 12 from each other
// 9. Textfields should have a spacing of 40 from top labels
// 10. Login button should have 16 spacing from textfields
final class Task3ViewController: UIViewController {
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let usernameField = UITextField()
    private let passwordField = UITextField()
    private let logInButton = UIButton()
    
    private let contentView = UIView()
    private var contentViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupView()
        setupGestures()
        setupKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupGestures() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endEditing)))
    }
    
    @objc private func endEditing() {
        view.endEditing(true)
    }
    
    private func setupView() {
        setupLabels()
        setupTextFields()
        setupButton()
        
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            contentView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        contentViewBottomConstraint = contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        contentViewBottomConstraint.isActive = true
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            bodyLabel,
            usernameField,
            passwordField,
            logInButton
        ])
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fill
        verticalStackView.spacing = 0
        
        contentView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        
        titleLabel.bottomAnchor.constraint(equalTo: bodyLabel.topAnchor, constant: -12).isActive = true
        
        usernameField.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 40).isActive = true
        
        logInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16).isActive = true
    }
    
    private func setupLabels() {
        titleLabel.text = "Sign In"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        bodyLabel.numberOfLines = 3
        bodyLabel.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit,
        sed do eiusmod tempor incididunt ut labore
        """
        bodyLabel.font = .systemFont(ofSize: 16)
        bodyLabel.textColor = .secondaryLabel
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTextFields() {
        usernameField.placeholder = "Enter username"
        passwordField.placeholder = "Enter password"
        usernameField.borderStyle = .roundedRect
        passwordField.borderStyle = .roundedRect
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        
        usernameField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    private func setupButton() {
        logInButton.setTitle("Log In", for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.backgroundColor = .systemBlue
        logInButton.layer.cornerRadius = 8
        logInButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        logInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: - Keyboard Handling
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        let intersection = keyboardFrame.cgRectValue.intersection(view.safeAreaLayoutGuide.layoutFrame)
        let bottomInset = intersection.height
        
        contentViewBottomConstraint.constant = -bottomInset - 20
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return
        }
        
        contentViewBottomConstraint.constant = -20
        
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curve), animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

#Preview {
    Task3ViewController()
}
