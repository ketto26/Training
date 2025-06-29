//
//  ProfileViewController.swift
//  MultiTabApp
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Properties
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default User"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var editProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemIndigo
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupNavigationBarButtons()
        print("ProfileViewController: viewDidLoad()")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ProfileViewController: viewWillAppear(_:)")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ProfileViewController: viewDidAppear(_:)")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("ProfileViewController: viewWillLayoutSubviews()")
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("ProfileViewController: viewDidLayoutSubviews()")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ProfileViewController: viewWillDisappear(_:)")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ProfileViewController: viewDidDisappear(_:)")
    }

    // MARK: - UI Setup
    private func setupUI() {
        self.navigationItem.title = "Profile"

        view.addSubview(nameLabel)
        view.addSubview(editProfileButton)

        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editProfileButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            editProfileButton.widthAnchor.constraint(equalToConstant: 200),
            editProfileButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func setupNavigationBarButtons() {
        let editNameButton = UIBarButtonItem(
            image: UIImage(systemName: "pencil.slash"),
            style: .plain,
            target: self,
            action: #selector(editNameTapped)
        )

        let anonymousButton = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(setAnonymousNameTapped)
        )

        navigationItem.rightBarButtonItems = [anonymousButton, editNameButton]
    }

    // MARK: - Actions
    @objc private func editProfileButtonTapped() {
        let editProfileVC = EditProfileViewController()
        navigationController?.pushViewController(editProfileVC, animated: true)
    }

    @objc private func editNameTapped() {
        let alert = UIAlertController(
            title: "Change Name",
            message: "Enter your new name:",
            preferredStyle: .alert
        )

        alert.addTextField { textField in
            textField.placeholder = "New Name"
            textField.text = self.nameLabel.text
        }

        let updateAction = UIAlertAction(title: "Update", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                self.nameLabel.text = newName
            } else {
                self.nameLabel.text = "Default"
            }
        }
        alert.addAction(updateAction)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    @objc private func setAnonymousNameTapped() {
        nameLabel.text = "Anonymous"
    }
}
