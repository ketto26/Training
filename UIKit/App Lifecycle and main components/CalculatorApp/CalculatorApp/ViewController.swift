//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Keto Nioradze on 28.06.25.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Components

    let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 50, weight: .light)
        label.text = "0"
        return label
    }()

    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("C", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        return button
    }()

    var numberButtons: [UIButton] = []
    var operationButtons: [UIButton] = []

    // MARK: - Calculator Logic Properties
    var currentNumber: String = ""
    var previousNumber: String = ""
    var operation: String?
    var performingMath: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setupResultLabel()
        setupButtons()
        setupLayout()
    }

    // MARK: - UI Setup Methods

    private func setupResultLabel() {
        view.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            resultLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    private func setupButtons() {
        for i in 0...9 {
            let button = UIButton(type: .system)
            button.setTitle("\(i)", for: .normal)
            button.backgroundColor = UIColor(white: 0.2, alpha: 1)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            button.tag = i
            button.layer.cornerRadius = 5
            button.addTarget(self, action: #selector(numberButtonTapped(_:)), for: .touchUpInside)
            numberButtons.append(button)
        }

        let operations = ["/", "*", "-", "+", "="]
        for op in operations {
            let button = UIButton(type: .system)
            button.setTitle(op, for: .normal)
            button.backgroundColor = .orange
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            button.layer.cornerRadius = 5
            button.addTarget(self, action: #selector(operationButtonTapped(_:)), for: .touchUpInside)
            operationButtons.append(button)
        }

        clearButton.layer.cornerRadius = 5
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        let spacing: CGFloat = 10

        let mainButtonsStackView = UIStackView()
        mainButtonsStackView.axis = .vertical
        mainButtonsStackView.distribution = .fillEqually
        mainButtonsStackView.spacing = spacing
        mainButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainButtonsStackView)

        NSLayoutConstraint.activate([
            mainButtonsStackView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: spacing),
            mainButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: spacing),
            mainButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -spacing),
            mainButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -spacing)
        ])

        let row1Titles = ["C", "/", "*", "-"]
        let row2Titles = ["7", "8", "9", "+"]
        let row3Titles = ["4", "5", "6", "="]
        let row4Titles = ["1", "2", "3"]
        let row5Titles = ["0"]
        
        let allTitles = [row1Titles, row2Titles, row3Titles, row4Titles, row5Titles]

        var buttonMap: [String: UIButton] = [:]
        buttonMap["C"] = clearButton
        buttonMap["/"] = operationButtons[0]
        buttonMap["*"] = operationButtons[1]
        buttonMap["-"] = operationButtons[2]
        buttonMap["+"] = operationButtons[3]
        buttonMap["="] = operationButtons[4]

        for button in numberButtons {
            buttonMap[button.titleLabel!.text!] = button
        }

        for titlesInRow in allTitles {
            let rowStackView = UIStackView()
            rowStackView.axis = .horizontal
            rowStackView.distribution = .fillEqually
            rowStackView.spacing = spacing

            for title in titlesInRow {
                if title.hasPrefix("dummy") {
                    let dummyView = UIView()
                    rowStackView.addArrangedSubview(dummyView)
                } else if let button = buttonMap[title] {
                    rowStackView.addArrangedSubview(button)
                }
            }
            mainButtonsStackView.addArrangedSubview(rowStackView)
        }
    }

    // MARK: - Button Actions

    @objc func numberButtonTapped(_ sender: UIButton) {
        guard let numberString = sender.titleLabel?.text else { return }

        if performingMath {
            currentNumber = numberString
            performingMath = false
        } else {
            if currentNumber == "0" && numberString != "0" { // Replace "0" if new number is not "0"
                currentNumber = numberString
            } else if currentNumber == "0" && numberString == "0" {
                // Do nothing if current is "0" and new is "0" to prevent "00"
            } else {
                currentNumber += numberString
            }
        }
        resultLabel.text = currentNumber
    }

    @objc func operationButtonTapped(_ sender: UIButton) {
        guard let operationText = sender.titleLabel?.text else { return }

        if operationText == "=" {
            calculateResult()
            operation = nil
            // currentNumber already holds the result for chaining
            performingMath = true // Result is displayed, next number should start new input
        } else {
            if currentNumber != "" { // If user just entered a number
                previousNumber = currentNumber
                operation = operationText
                performingMath = true
            } else if previousNumber != "" { // If user changes operation after previous calculation
                operation = operationText
            }
            // If both currentNumber and previousNumber are empty (e.g., app just launched and user hits +), do nothing.
        }
    }


    @objc func clearButtonTapped() {
        currentNumber = ""
        previousNumber = ""
        operation = nil
        performingMath = false
        resultLabel.text = "0"
    }

    // MARK: - Calculator Logic

    private func calculateResult() {
        // If there's no previous number or current number, or no operation, don't calculate.
        guard let previous = Double(previousNumber),
              let current = Double(currentNumber),
              let op = operation else {
            // Handle cases where '=' is pressed without enough input
            if currentNumber != "" { // If only currentNumber exists, show it as result
                resultLabel.text = currentNumber
            }
            return
        }

        var result: Double = 0.0

        switch op {
        case "+":
            result = previous + current
        case "-":
            result = previous - current
        case "*":
            result = previous * current
        case "/":
            if current == 0 {
                resultLabel.text = "Error: Div by 0"
                currentNumber = ""
                previousNumber = ""
                operation = nil
                performingMath = false
                return
            }
            result = previous / current
        default:
            break
        }

        if result.truncatingRemainder(dividingBy: 1) == 0 {
            resultLabel.text = "\(Int(result))"
        } else {
            resultLabel.text = "\(result)"
        }

        currentNumber = "\(result)"
        previousNumber = ""

    }
}
