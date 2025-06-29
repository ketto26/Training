//
//  Model.swift
//  UITableView
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

// MARK: - Data Models
struct Trainer {
    let fullName: String
    let photo: UIImage? 
}

struct GymClass {
    let id: UUID
    let name: String
    let day: Date
    let time: Date
    let duration: Int
    let trainer: Trainer
    var isRegistered: Bool

    init(id: UUID = UUID(), name: String, dayString: String, timeString: String, duration: Int, trainer: Trainer, isRegistered: Bool) {
        self.id = id
        self.name = name
        self.duration = duration
        self.trainer = trainer
        self.isRegistered = isRegistered

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.day = dateFormatter.date(from: dayString)!

        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        self.time = timeFormatter.date(from: timeString)!
    }
}
