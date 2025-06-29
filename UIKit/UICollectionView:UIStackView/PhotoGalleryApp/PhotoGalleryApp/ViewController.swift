//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

// MARK: - ViewController (Main Photo Gallery Screen)
class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var photoSections: [PhotoSection] = []
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
    private let itemSpacing: CGFloat = 10.0
    private let sectionHeaderHeight: CGFloat = 50.0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Photo Gallery"
        view.backgroundColor = .systemBackground
        setupData()
        setupCollectionView()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] _ in
            self?.collectionView.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }

    // MARK: - Data Setup
    private func setupData() {
        let calendar = Calendar.current
        var photos: [Photo] = []

        let imageNames = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8"]
        for i in 0..<20 {
            let year = 2020 + (i % 3)
            var dateComponents = DateComponents()
            dateComponents.year = year
            dateComponents.month = Int.random(in: 1...12)
            dateComponents.day = Int.random(in: 1...28)
            let date = calendar.date(from: dateComponents) ?? Date()

            let imageName = imageNames[i % imageNames.count]
            photos.append(Photo(imageName: imageName, title: "Photo \(i + 1)", date: date, isFavorite: i % 3 == 0))
        }

        let groupedByYear = Dictionary(grouping: photos) { calendar.component(.year, from: $0.date) }
        photoSections = groupedByYear.map { (year, photosInYear) in
            PhotoSection(year: String(year), photos: photosInYear.sorted(by: { $0.date < $1.date }))
        }.sorted { $0.year > $1.year }
    }

    // MARK: - Collection View Setup
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        collectionView.register(SectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeaderView.reuseIdentifier)

        view.addSubview(collectionView)
    }

    // MARK: - Helper for Alert Display
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - Extensions

// MARK:  UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoSections.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoSections[section].photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue PhotoCell")
        }
        let photo = photoSections[indexPath.section].photos[indexPath.row]
        cell.configure(with: photo)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader,
              let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.reuseIdentifier, for: indexPath) as? SectionHeaderView else {
            fatalError("Unable to dequeue SectionHeaderView")
        }
        let sectionTitle = photoSections[indexPath.section].year
        header.configure(with: sectionTitle)
        return header
    }
}

// MARK: - UICollectionViewDelegateFlowLayout (Layout & Sizing)
extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let orientation = UIDevice.current.orientation
        let columns: CGFloat = orientation.isPortrait ? 3 : 4
        let totalHorizontalPadding = sectionInsets.left + sectionInsets.right
        let totalSpacing = (columns - 1) * itemSpacing
        let availableWidth = collectionView.bounds.width - totalHorizontalPadding - totalSpacing
        let widthPerItem = availableWidth / columns
        return CGSize(width: widthPerItem, height: widthPerItem * 2.5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: sectionHeaderHeight)
    }
}

// MARK: - PhotoCellDelegate (Handling Favorite Toggle)
extension ViewController: PhotoCellDelegate {
    func photoCellDidToggleFavorite(_ cell: PhotoCell, photoId: String) {
        var updatedIndexPath: IndexPath?
        var alertMessage: String = ""
        var updatedPhotoTitle: String = ""

        for sectionIndex in 0..<photoSections.count {
            if let photoIndex = photoSections[sectionIndex].photos.firstIndex(where: { $0.id == photoId }) {
                photoSections[sectionIndex].photos[photoIndex].isFavorite.toggle()
                let photo = photoSections[sectionIndex].photos[photoIndex]
                updatedIndexPath = IndexPath(row: photoIndex, section: sectionIndex)
                updatedPhotoTitle = photo.title
                alertMessage = photo.isFavorite ? "Marked \(photo.title) as Favorite!" : "Removed \(photo.title) from Favorites."
                break
            }
        }

        if let indexPath = updatedIndexPath {
            collectionView.reloadItems(at: [indexPath])
            showAlert(title: "Favorite Status", message: alertMessage)
        }
    }
}

// MARK: - UICollectionViewDelegate (For Context Menus / Swipe-to-Delete)
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let photo = photoSections[indexPath.section].photos[indexPath.row]

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let deleteAction = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { [weak self] _ in
                self?.deletePhoto(at: indexPath)
            }
            return UIMenu(title: "", children: [deleteAction])
        }
    }

    private func deletePhoto(at indexPath: IndexPath) {
        let photoTitle = photoSections[indexPath.section].photos[indexPath.row].title

        photoSections[indexPath.section].photos.remove(at: indexPath.row)

        if photoSections[indexPath.section].photos.isEmpty {
            photoSections.remove(at: indexPath.section)
            collectionView.deleteSections(IndexSet(integer: indexPath.section))
        } else {
            collectionView.deleteItems(at: [indexPath])
        }
        showAlert(title: "Photo Deleted", message: "Removed '\(photoTitle)' from the gallery.")
    }
}
