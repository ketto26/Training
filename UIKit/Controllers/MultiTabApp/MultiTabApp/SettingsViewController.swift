//
//  SettingsViewController.swift
//  MultiTabApp
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Properties
    private let toggleLabel: UILabel = {
        let label = UILabel()
        label.text = "Navigation is easy!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let easyNavigationToggle: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        uiSwitch.isOn = true
        return uiSwitch
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        self.navigationItem.title = "Settings"
    }

    // MARK: - UI Setup
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [toggleLabel, easyNavigationToggle])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20) 
        ])
    }
}
