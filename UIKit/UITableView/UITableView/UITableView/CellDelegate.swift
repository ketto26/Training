//
//  CellDelegate.swift
//  UITableView
//
//  Created by Keto Nioradze on 29.06.25.
//

import Foundation

// MARK: - Custom Table View Cell
protocol GymClassCellDelegate: AnyObject {
    func didTapRegisterButton(for classId: UUID)
}
