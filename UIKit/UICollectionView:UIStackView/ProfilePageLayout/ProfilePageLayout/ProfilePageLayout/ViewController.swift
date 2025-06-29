//
//  ViewController.swift
//  ProfilePageLayout
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Static Data
    private let userName = "John Doe"
    private let userBio = "Passionate iOS Developer | Swift Enthusiast | Lifelong Learner. Building beautiful and functional apps."
    private let followerCount = "1.2M"
    private let followingCount = "500"
    private let postCount = "120"

    // MARK: - UI Elements
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    private let followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        return button
    }()

    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let followerCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    private let followerTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Followers"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    private let followingCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    private let followingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Following"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    private let postCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    private let postTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "Posts"
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()

    // Extra Practice Elements
    private lazy var toggleTaggedPostsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Toggle Tagged Posts", for: .normal)
        button.addTarget(self, action: #selector(toggleTaggedPosts), for: .touchUpInside)
        return button
    }()

    private lazy var taggedPostsSection: UIStackView = {
        let label = UILabel()
        label.text = "This is the Tagged Posts Section"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.textColor = .systemGreen

        let stack = UIStackView(arrangedSubviews: [label])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 10
        stack.isHidden = true
        return stack
    }()

    private lazy var toggleBioVisibilityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Toggle Bio Visibility", for: .normal)
        button.addTarget(self, action: #selector(toggleBioVisibility), for: .touchUpInside)
        return button
    }()

    // MARK: - Stack Views
    private lazy var profileHeaderStackView: UIStackView = {
        let nameAndButtonStack = UIStackView(arrangedSubviews: [nameLabel, followButton])
        nameAndButtonStack.axis = .vertical
        nameAndButtonStack.alignment = .center
        nameAndButtonStack.spacing = 8

        let stack = UIStackView(arrangedSubviews: [profileImageView, nameAndButtonStack])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 20
        stack.distribution = .fillProportionally
        return stack
    }()

    private lazy var statisticsStackView: UIStackView = {
        let followersStack = UIStackView(arrangedSubviews: [followerCountLabel, followerTitleLabel])
        followersStack.axis = .vertical
        followersStack.alignment = .center
        followersStack.spacing = 4

        let followingStack = UIStackView(arrangedSubviews: [followingCountLabel, followingTitleLabel])
        followingStack.axis = .vertical
        followingStack.alignment = .center
        followingStack.spacing = 4

        let postsStack = UIStackView(arrangedSubviews: [postCountLabel, postTitleLabel])
        postsStack.axis = .vertical
        postsStack.alignment = .center
        postsStack.spacing = 4

        let stack = UIStackView(arrangedSubviews: [followersStack, followingStack, postsStack])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()

    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            profileHeaderStackView,
            bioLabel,
            statisticsStackView,
            taggedPostsSection,
            toggleTaggedPostsButton,
            toggleBioVisibilityButton
        ])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 30
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupData()
        setupLayout()
    }

    // MARK: - Setup
    private func setupData() {
        nameLabel.text = userName
        bioLabel.text = userBio
        followerCountLabel.text = followerCount
        followingCountLabel.text = followingCount
        postCountLabel.text = postCount
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            mainStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40)
        ])

        profileHeaderStackView.isLayoutMarginsRelativeArrangement = true
        profileHeaderStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

        statisticsStackView.isLayoutMarginsRelativeArrangement = true
        statisticsStackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    // MARK: - Extra Practice Actions
    @objc private func toggleTaggedPosts() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: {
            self.taggedPostsSection.isHidden.toggle()
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    @objc private func toggleBioVisibility() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bioLabel.isHidden.toggle()
            self.view.layoutIfNeeded()
        })
    }
}
