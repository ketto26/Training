//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.
final class Task4ViewController: UIViewController {
    
    private let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topView, bottomView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupUI()
        registerForTraitChanges()
    }
    
    private func setupUI() {
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }

    private func registerForTraitChanges() {
            let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
            registerForTraitChanges(sizeTraits) { (self: Self, previousTraitCollection: UITraitCollection) in
                print("Trait collection changed:", self.traitCollection)
                self.handleTraitChange()
            }
        }

        private func handleTraitChange() {
            let horizontalClass = traitCollection.horizontalSizeClass
            let verticalClass = traitCollection.verticalSizeClass

            let isCompactWidthRegularHeight = (horizontalClass == .compact && verticalClass == .regular)

            let isCompactCompact = (horizontalClass == .compact && verticalClass == .compact)

            if isCompactWidthRegularHeight {
                mainStackView.axis = .vertical
                print("Layout: Vertical (Compact Width, Regular Height)")
            } else if isCompactCompact {
                mainStackView.axis = .horizontal
                print("Layout: Horizontal (Compact-Compact)")
            } else {
                mainStackView.axis = .vertical
                print("Layout: Default Vertical (Other Trait)")
            }

            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
}

#Preview {
    Task4ViewController()
}
