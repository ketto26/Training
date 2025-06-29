//
//  PersonalInfoViewController.swift
//  MultiTabApp
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

class PersonalInfoViewController: UIViewController {

    // MARK: - Properties
    var userData = UserData()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .words
        return textField
    }()

    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your phone number"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupTextFieldDelegates()
        
        self.navigationItem.title = "Personal Info"
    }

    // MARK: - UI Setup
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, phoneTextField, confirmButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            phoneTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupTextFieldDelegates() {
        nameTextField.delegate = self
        phoneTextField.delegate = self
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    // MARK: - Actions
    @objc private func confirmButtonTapped() {
        let name = nameTextField.text ?? ""
        let phone = phoneTextField.text ?? ""

        userData.name = name
        userData.phoneNumber = phone

        let alert = UIAlertController(
            title: "Confirm Information",
            message: "Please confirm your name and phone number.\nName: \(name)\nPhone: \(phone)",
            preferredStyle: .alert
        )

        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let preferencesVC = PreferencesViewController()
            preferencesVC.userData = self.userData
            self.navigationController?.pushViewController(preferencesVC, animated: true)
        }
        alert.addAction(confirmAction)

        let editAction = UIAlertAction(title: "Edit", style: .cancel, handler: nil)
        alert.addAction(editAction)

        present(alert, animated: true, completion: nil)
    }

    private func validateInput() {
        let isNameValid = !(nameTextField.text?.isEmpty ?? true)
        let isPhoneValid = (phoneTextField.text?.count ?? 0) >= 9
        confirmButton.isEnabled = isNameValid && isPhoneValid
    }
}

// MARK: - UITextFieldDelegate
extension PersonalInfoViewController: UITextFieldDelegate {
    @objc func textFieldDidChange(_ textField: UITextField) {
        validateInput()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
