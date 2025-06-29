//
//  PreferencesViewController.swift
//  MultiTabApp
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

class PreferencesViewController: UIViewController {

    // MARK: - Properties
    var userData: UserData!

    private lazy var selectPreferenceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Notification Preference", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(selectPreferenceButtonTapped), for: .touchUpInside)
        return button
    }()

    private let preferenceLabel: UILabel = {
        let label = UILabel()
        label.text = "No preference selected."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        self.navigationItem.title = "Preferences"
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(selectPreferenceButton)
        view.addSubview(preferenceLabel)

        NSLayoutConstraint.activate([
            selectPreferenceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            selectPreferenceButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            selectPreferenceButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            selectPreferenceButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            selectPreferenceButton.heightAnchor.constraint(equalToConstant: 50),

            preferenceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            preferenceLabel.topAnchor.constraint(equalTo: selectPreferenceButton.bottomAnchor, constant: 20),
            preferenceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            preferenceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - Actions
    @objc private func selectPreferenceButtonTapped() {
        let actionSheet = UIAlertController(
            title: "Select Notification Preference",
            message: "How would you like to receive updates or notifications?",
            preferredStyle: .actionSheet
        )

        let emailAction = UIAlertAction(title: "Email Notifications", style: .default) { [weak self] _ in
            self?.updatePreference(with: "Email Notifications")
        }
        actionSheet.addAction(emailAction)

        let smsAction = UIAlertAction(title: "SMS Notifications", style: .default) { [weak self] _ in
            self?.updatePreference(with: "SMS Notifications")
        }
        actionSheet.addAction(smsAction)

        let pushAction = UIAlertAction(title: "Push Notifications", style: .default) { [weak self] _ in
            self?.updatePreference(with: "Push Notifications")
        }
        actionSheet.addAction(pushAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
    }

    private func updatePreference(with preference: String) {
        preferenceLabel.text = "Current Preference: \(preference)"
        userData.notificationPreference = preference

        let confirmDetailsVC = ConfirmDetailsViewController()
        confirmDetailsVC.userData = userData
        navigationController?.pushViewController(confirmDetailsVC, animated: true)
    }
}
