//
//  ConfirmDetailsViewController.swift
//  MultiTabApp
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

class ConfirmDetailsViewController: UIViewController {

    // MARK: - Properties
    var userData: UserData!

    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let preferenceLabel = UILabel()

    private lazy var startOverButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start Over", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(startOverTapped), for: .touchUpInside)
        return button
    }()

    private lazy var editPreferencesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Preferences", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemOrange
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(editPreferencesTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var editPersonalInfoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Personal Info", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(editPersonalInfoTapped), for: .touchUpInside)
        return button
    }()

    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Confirm Onboarding", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(confirmOnboardingTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        displaySummary()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Summary"
    }

    // MARK: - UI Setup
    private func setupUI() {
        let labels = [nameLabel, phoneLabel, preferenceLabel]
        for label in labels {
            label.font = UIFont.systemFont(ofSize: 18)
            label.textAlignment = .center
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
        }

        let summaryStackView = UIStackView(arrangedSubviews: labels)
        summaryStackView.axis = .vertical
        summaryStackView.spacing = 10
        summaryStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(summaryStackView)

        let buttons = [startOverButton, editPreferencesButton, editPersonalInfoButton, confirmButton]
        let buttonStackView = UIStackView(arrangedSubviews: buttons)
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 15
        buttonStackView.distribution = .fillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            summaryStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            summaryStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            summaryStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            summaryStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: summaryStackView.bottomAnchor, constant: 50),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            buttonStackView.heightAnchor.constraint(equalToConstant: 4 * 50 + 3 * 15)
        ])
        
        buttons.forEach { $0.heightAnchor.constraint(equalToConstant: 50).isActive = true }
    }

    private func displaySummary() {
        nameLabel.text = "Name: \(userData.name ?? "N/A")"
        phoneLabel.text = "Phone Number: \(userData.phoneNumber ?? "N/A")"
        preferenceLabel.text = "Notification Preference: \(userData.notificationPreference ?? "N/A")"
    }

    // MARK: - Actions
    @objc private func startOverTapped() {
        if let onboardingVC = navigationController?.viewControllers.first as? OnboardingViewController {
            onboardingVC.resetOnboardingButton()
        }
        navigationController?.popToRootViewController(animated: true)
    }

    @objc private func editPreferencesTapped() {
        for controller in navigationController?.viewControllers ?? [] {
            if controller is PreferencesViewController {
                navigationController?.popToViewController(controller, animated: true)
                return
            }
        }
    }
    
    @objc private func editPersonalInfoTapped() {
        for controller in navigationController?.viewControllers ?? [] {
            if controller is PersonalInfoViewController {
                navigationController?.popToViewController(controller, animated: true)
                return
            }
        }
    }

    @objc private func confirmOnboardingTapped() {
        let alert = UIAlertController(
            title: "Onboarding Complete!",
            message: "You have successfully passed the onboarding process.",
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let onboardingVC = self.navigationController?.viewControllers.first as? OnboardingViewController {
                onboardingVC.setOnboardingButtonToRestart() 
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
}
