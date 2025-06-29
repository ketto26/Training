//
//  ViewController.swift
//  ImageDisplay
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

// MARK: - ImageDisplayViewController
class ImageDisplayViewController: UIViewController {

    // MARK: - UI Components
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        return scrollView
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupImage()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        recenterImage()
    }

    // MARK: - UI Setup Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.delegate = self

        scrollView.addSubview(imageView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),

            imageView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            imageView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }

    private func setupImage() {
        if let image = UIImage(named: "MainImage") {
            imageView.image = image

            scrollView.contentSize = image.size
        } else {
            print("Error: Could not load image. Please check the image asset name.")
        }
    }

    // MARK: - Centering Logic
    private func recenterImage() {
        let contentWidth = scrollView.contentSize.width
        let contentHeight = scrollView.contentSize.height

        let scrollViewWidth = scrollView.bounds.size.width
        let scrollViewHeight = scrollView.bounds.size.height

        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0

        if contentWidth < scrollViewWidth {
            offsetX = (scrollViewWidth - contentWidth) * 0.5
        }

        if contentHeight < scrollViewHeight {
            offsetY = (scrollViewHeight - contentHeight) * 0.5
        }

        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: offsetY, right: offsetX)
    }
}

// MARK: - UIScrollViewDelegate Extension
extension ImageDisplayViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        recenterImage()
    }
}
