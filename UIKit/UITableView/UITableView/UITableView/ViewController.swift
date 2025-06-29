//
//  ViewController.swift
//  UITableView
//
//  Created by Keto Nioradze on 29.06.25.
//

import UIKit

// MARK: - Main View Controller
class GymScheduleViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .grouped)

    // MARK: - Data Source Properties
    private var allGymClasses: [GymClass] = []
    private var groupedClasses: [Date: [GymClass]] = [:]
    private var sortedSectionDates: [Date] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wellness classes"
        view.backgroundColor = .systemBackground
        setupData()
        setupTableView()
    }

    private func setupData() {
        // Define Trainers
        let agataWojcik = Trainer(fullName: "Agata Wójcik", photo: UIImage(systemName: "person.fill"))
        let ewaPietrzyk = Trainer(fullName: "Ewa Pietrzyk", photo: UIImage(systemName: "person.fill"))
        let janKowalski = Trainer(fullName: "John Doe", photo: UIImage(systemName: "person.fill"))


        allGymClasses = [
            GymClass(name: "Stretching", dayString: "2025-07-21", timeString: "18:00", duration: 55, trainer: agataWojcik, isRegistered: false),
            GymClass(name: "Yoga Flow", dayString: "2025-07-21", timeString: "19:00", duration: 60, trainer: ewaPietrzyk, isRegistered: true),

            GymClass(name: "Stretching", dayString: "2025-07-22", timeString: "10:00", duration: 55, trainer: ewaPietrzyk, isRegistered: false),
            GymClass(name: "Pilates", dayString: "2025-07-22", timeString: "15:00", duration: 55, trainer: agataWojcik, isRegistered: false),
            GymClass(name: "Zumba", dayString: "2025-07-22", timeString: "18:30", duration: 45, trainer: janKowalski, isRegistered: true),

            GymClass(name: "Spinning", dayString: "2025-07-23", timeString: "09:00", duration: 45, trainer: janKowalski, isRegistered: false),
            GymClass(name: "Body Pump", dayString: "2025-07-23", timeString: "17:00", duration: 60, trainer: agataWojcik, isRegistered: false),

            GymClass(name: "Stretching", dayString: "2025-07-24", timeString: "09:00", duration: 55, trainer: agataWojcik, isRegistered: false),
            GymClass(name: "HIIT", dayString: "2025-07-24", timeString: "18:00", duration: 45, trainer: ewaPietrzyk, isRegistered: true),

            GymClass(name: "Aqua Aerobics", dayString: "2025-07-25", timeString: "11:00", duration: 50, trainer: janKowalski, isRegistered: false),
            GymClass(name: "Pilates", dayString: "2025-07-25", timeString: "16:00", duration: 55, trainer: agataWojcik, isRegistered: false),
        ]
        
        groupClassesByDay()
    }

    private func groupClassesByDay() {
        groupedClasses = Dictionary(grouping: allGymClasses, by: { gymClass in
            let calendar = Calendar.current
            return calendar.date(from: calendar.dateComponents([.year, .month, .day], from: gymClass.day))!
        })

        sortedSectionDates = groupedClasses.keys.sorted(by: { $0 < $1 })

        for (date, classes) in groupedClasses {
            groupedClasses[date] = classes.sorted(by: { $0.time < $1.time })
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GymClassCell.self, forCellReuseIdentifier: GymClassCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
    }

    // MARK: - Helper Methods for Data Manipulation
    private func findGymClassIndex(for classId: UUID) -> (section: Int, row: Int)? {
        for (sectionIndex, date) in sortedSectionDates.enumerated() {
            if let classesForDay = groupedClasses[date] {
                if let rowIndex = classesForDay.firstIndex(where: { $0.id == classId }) {
                    return (sectionIndex, rowIndex)
                }
            }
        }
        return nil
    }

    private func showRegistrationAlert(for gymClass: GymClass) {
        let message: String
        if gymClass.isRegistered {
            message = "You have registered to \(gymClass.name), see you there!"
        } else {
            message = "You have just cancelled \(gymClass.name) :("
        }
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extensions

// MARK: UITableViewDataSource
extension GymScheduleViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sortedSectionDates.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = sortedSectionDates[section]
        return groupedClasses[date]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GymClassCell.reuseIdentifier, for: indexPath) as? GymClassCell else {
            fatalError("Unable to dequeue GymClassCell")
        }

        let date = sortedSectionDates[indexPath.section]
        if let gymClass = groupedClasses[date]?[indexPath.row] {
            cell.configure(with: gymClass, delegate: self)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = sortedSectionDates[section]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MMM yyyy"
        return dateFormatter.string(from: date)
    }
}

// MARK: - UITableViewDelegate
extension GymScheduleViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            header.textLabel?.textColor = .darkText
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self = self else {
                completionHandler(false)
                return
            }

            let date = self.sortedSectionDates[indexPath.section]
            guard var classesForDay = self.groupedClasses[date] else {
                completionHandler(false)
                return
            }

            let deletedClass = classesForDay.remove(at: indexPath.row)
            self.allGymClasses.removeAll(where: { $0.id == deletedClass.id })

            if classesForDay.isEmpty {
                self.groupedClasses.removeValue(forKey: date)
                self.sortedSectionDates.remove(at: indexPath.section)
                tableView.deleteSections(IndexSet(integer: indexPath.section), with: .fade)
            } else {
                self.groupedClasses[date] = classesForDay
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

// MARK: - GymClassCellDelegate
extension GymScheduleViewController: GymClassCellDelegate {
    func didTapRegisterButton(for classId: UUID) {
        if let (section, row) = findGymClassIndex(for: classId) {
            let date = sortedSectionDates[section]
            if var gymClass = groupedClasses[date]?[row] {
                gymClass.isRegistered.toggle()
                groupedClasses[date]?[row] = gymClass
                
                if let allIndex = allGymClasses.firstIndex(where: { $0.id == classId }) {
                    allGymClasses[allIndex].isRegistered = gymClass.isRegistered
                }

                tableView.reloadRows(at: [IndexPath(row: row, section: section)], with: .none)
                showRegistrationAlert(for: gymClass)
            }
        }
    }
}
