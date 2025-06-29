//
//  UICollectionViewCell.swift
//  PhotoGalleryApp
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

// MARK: - Custom UICollectionViewCell
protocol PhotoCellDelegate: AnyObject {
    func photoCellDidToggleFavorite(_ cell: PhotoCell, photoId: String)
}

class PhotoCell: UICollectionViewCell {
    static let reuseIdentifier = "PhotoCell"

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemRed
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()

    private var photoId: String?
    weak var delegate: PhotoCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        
        let textStackView = UIStackView(arrangedSubviews: [titleLabel, favoriteButton])
        textStackView.axis = .horizontal
        textStackView.alignment = .center
        textStackView.distribution = .fillProportionally
        textStackView.spacing = 4
        textStackView.isLayoutMarginsRelativeArrangement = true
        textStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)


        let stackView = UIStackView(arrangedSubviews: [imageView, textStackView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.75),

            favoriteButton.widthAnchor.constraint(equalToConstant: 30),
            favoriteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configure(with photo: Photo) {
        self.photoId = photo.id
        imageView.image = UIImage(named: photo.imageName) ?? UIImage(systemName: "photo")
        titleLabel.text = photo.title
        updateFavoriteButton(isFavorite: photo.isFavorite)
    }

    private func updateFavoriteButton(isFavorite: Bool) {
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    // MARK: - Actions
    @objc private func favoriteButtonTapped() {
        guard let photoId = photoId else { return }
        delegate?.photoCellDidToggleFavorite(self, photoId: photoId)
    }
}
