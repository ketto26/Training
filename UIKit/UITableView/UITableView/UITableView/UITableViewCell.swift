//
//  UITableViewCell.swift
//  UITableView
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

class GymClassCell: UITableViewCell {
    static let reuseIdentifier = "GymClassCell"

    private let timeLabel = UILabel()
    private let durationLabel = UILabel()
    private let classNameLabel = UILabel()
    private let trainerImageView = UIImageView()
    private let trainerNameLabel = UILabel()
    private let registerButton = UIButton(type: .system)

    weak var delegate: GymClassCellDelegate?
    private var classId: UUID?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        timeLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeLabel)

        durationLabel.font = UIFont.systemFont(ofSize: 14)
        durationLabel.textColor = .gray
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(durationLabel)

        classNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        classNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(classNameLabel)

        trainerImageView.contentMode = .scaleAspectFill
        trainerImageView.clipsToBounds = true
        trainerImageView.layer.cornerRadius = 15
        trainerImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trainerImageView)

        trainerNameLabel.font = UIFont.systemFont(ofSize: 14)
        trainerNameLabel.textColor = .darkGray
        trainerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(trainerNameLabel)

        registerButton.tintColor = .systemPink
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(registerButton)

        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),

            durationLabel.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            durationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 2),

            classNameLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 20),
            classNameLabel.centerYAnchor.constraint(equalTo: timeLabel.centerYAnchor),
            classNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: registerButton.leadingAnchor, constant: -10),

            trainerImageView.leadingAnchor.constraint(equalTo: classNameLabel.leadingAnchor),
            trainerImageView.topAnchor.constraint(equalTo: classNameLabel.bottomAnchor, constant: 5),
            trainerImageView.widthAnchor.constraint(equalToConstant: 30),
            trainerImageView.heightAnchor.constraint(equalToConstant: 30),
            trainerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            trainerNameLabel.leadingAnchor.constraint(equalTo: trainerImageView.trailingAnchor, constant: 8),
            trainerNameLabel.centerYAnchor.constraint(equalTo: trainerImageView.centerYAnchor),
            trainerNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: registerButton.leadingAnchor, constant: -10),

            registerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            registerButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 44),
            registerButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    func configure(with gymClass: GymClass, delegate: GymClassCellDelegate) {
        self.classId = gymClass.id
        self.delegate = delegate

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeLabel.text = timeFormatter.string(from: gymClass.time)

        durationLabel.text = "\(gymClass.duration)m"
        classNameLabel.text = gymClass.name
        trainerNameLabel.text = gymClass.trainer.fullName
        trainerImageView.image = gymClass.trainer.photo ?? UIImage(systemName: "person.circle.fill")
        updateRegisterButton(isRegistered: gymClass.isRegistered)
    }

    private func updateRegisterButton(isRegistered: Bool) {
        let imageName = isRegistered ? "xmark.circle.fill" : "plus.circle.fill"
        registerButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    @objc private func registerButtonTapped() {
        guard let classId = classId else { return }
        delegate?.didTapRegisterButton(for: classId)
    }
}
