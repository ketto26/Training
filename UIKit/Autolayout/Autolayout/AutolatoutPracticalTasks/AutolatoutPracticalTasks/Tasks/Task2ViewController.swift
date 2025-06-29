//
//  Task2.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Build a UI programmatically with a UIButton positioned below a UILabel.
// The button should be centered horizontally and have a fixed distance from the label.
// Adjust the layout to handle different screen sizes.
final class Task2ViewController: UIViewController {
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, Auto Layout!"
        label.backgroundColor = .lightGray
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let myButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap Me!", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupUI()
    }
    
    private func setupUI() {
            view.addSubview(myLabel)
            view.addSubview(myButton)

            let spacing: CGFloat = 20.0
            let horizontalPadding: CGFloat = 40.0
            NSLayoutConstraint.activate([
                //Label Constraints
                myLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                myLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
                myLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
                myLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),

                // Button Constraints
                myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                myButton.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: spacing),
                myButton.widthAnchor.constraint(equalToConstant: 150),
                myButton.heightAnchor.constraint(equalToConstant: 50) 
            ])
        }
}

#Preview {
    Task2ViewController()
}
