//
//  EditProfileViewController.swift
//  MultiTabApp
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

class EditProfileViewController: UIViewController {

    // MARK: - Properties
    private let visualizationLabel: UILabel = {
        let label = UILabel()
        label.text = "You are in Edit Profile"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        print("EditProfileViewController: viewDidLoad()")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("EditProfileViewController: viewWillAppear(_:)")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("EditProfileViewController: viewDidAppear(_:)")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("EditProfileViewController: viewWillLayoutSubviews()")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("EditProfileViewController: viewDidLayoutSubviews()")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("EditProfileViewController: viewWillDisappear(_:)")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("EditProfileViewController: viewDidDisappear(_:)")
    }

    // MARK: - UI Setup
    private func setupUI() {
        self.navigationItem.title = "Edit Profile"

        view.addSubview(visualizationLabel)

        NSLayoutConstraint.activate([
            visualizationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            visualizationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
