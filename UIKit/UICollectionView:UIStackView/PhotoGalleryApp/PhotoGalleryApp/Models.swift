//
//  Models.swift
//  PhotoGalleryApp
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

// MARK: - Photo Model
struct Photo: Identifiable, Hashable {
    let id = UUID().uuidString
    var imageName: String
    let title: String
    let date: Date
    var isFavorite: Bool
}

// MARK: - Photo Section Model (for Collection View Headers)
struct PhotoSection: Identifiable, Hashable {
    let id = UUID().uuidString
    let year: String
    var photos: [Photo]
}

