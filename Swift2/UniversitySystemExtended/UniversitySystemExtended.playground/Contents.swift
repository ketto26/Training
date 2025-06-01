
// MARK: - Task 3: University Student Management System – Extended Version

import Foundation

// --- 1. Modified Person Base Class ---
class Person {
    let name: String
    let age: Int

    // Computed property
    var isAdult: Bool {
        return age >= 18
    }

    // Static property
    static let minAgeForEnrollment: Int = 16

    // Lazy property
    lazy var profileDescription: String = {
        return "\(self.name) is \(self.age) years old."
    }()

    // Retaining initializers
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

    init?(name: String, ageIfValid: Int) {
        guard ageIfValid >= Person.minAgeForEnrollment else {
            return nil
        }
        self.name = name
        self.age = ageIfValid
    }
}

// --- 2. Modified Student subclass---
class Student: Person {
    let studentID: String
    var major: String

    // Static counter
    static var studentCount: Int = 0

    // Weak reference to an optional Professor
    weak var advisor: Professor?

    // Computed property to format studentID
    var formattedID: String {
        return "ID: \(studentID.uppercased())"
    }

    // Retaining initializers
    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
         Student.studentCount += 1
    }

    convenience init(name: String, age: Int, studentID: String) {
        self.init(name: name, age: age, studentID: studentID, major: "Undeclared")
    }

    init?(name: String, ageIfValid: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, ageIfValid: ageIfValid)
        guard ageIfValid >= Person.minAgeForEnrollment else {
            return nil
        }
         Student.studentCount += 1
    }

     deinit {
         Student.studentCount -= 1
     }
}

// --- 3. Modified Professor subclass ---
class Professor: Person {
    let faculty: String

    // Static counter for professors
    static var professorCount: Int = 0

    // Computed property for fullTitle
    var fullTitle: String {
        return "Prof. \(name), \(faculty) Department"
    }

    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
         Professor.professorCount += 1
    }

     deinit {
         Professor.professorCount -= 1
     }
}

// --- 4. Modified University struct ---
struct University {
    let name: String
    let location: String

    // Computed property (description)
    var description: String {
        return "\(name) located in \(location)."
    }
}
