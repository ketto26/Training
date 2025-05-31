

import Foundation

// --- 1. Person Base Class ---
class Person {
    let name: String
    let age: Int

    // Designated Initializer
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        print("Person (Designated Init): \(name), \(age) years old, initialized.")
    }

    // Failable Initializer
    init?(name: String, ageIfValid: Int) {
        guard ageIfValid >= 16 else {
            print("Person (Failable Init): Initialization failed for \(name). Age \(ageIfValid) is less than 16.")
            return nil
        }
        self.name = name
        self.age = ageIfValid
        print("Person (Failable Init): \(name), \(age) years old, successfully initialized.")
    }

    func describe() {
        print("I am \(name), \(age) years old.")
    }
}



// --- 2. Student Subclass ---
class Student: Person {
    let studentID: String
    var major: String

    // Required Initializer
    required init(name: String, age: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, age: age)
        print("Student (Required/Designated Init): \(name), ID: \(studentID), Major: \(major) initialized.")
    }

    // Convenience Initializer
    convenience init(name: String, age: Int, studentID: String) {
        self.init(name: name, age: age, studentID: studentID, major: "Undeclared")
        print("Student (Convenience Init): \(name), ID: \(studentID) initialized with default major.")
    }

    // Designated initializer calling failable super.init
    init?(name: String, ageIfValid: Int, studentID: String, major: String) {
        self.studentID = studentID
        self.major = major
        super.init(name: name, ageIfValid: ageIfValid)
        if ageIfValid < 16 {
             print("Student (Designated Init using Failable Super): Initialization failed for \(name) due to age.")
        } else {
            print("Student (Designated Init using Failable Super): \(name), ID: \(studentID), Major: \(major) initialized.")
        }
    }

    override func describe() {
        super.describe()
        print("I am a student with ID \(studentID), majoring in \(major).")
    }
}



// --- 3. Professor Subclass ---
class Professor: Person {
    let faculty: String

    // Custom Initializer (Designated Initializer for Professor)
    init(name: String, age: Int, faculty: String) {
        self.faculty = faculty
        super.init(name: name, age: age)
        print("Professor (Designated Init): Dr. \(name), Faculty: \(faculty) initialized.")
    }

    override func describe() {
        super.describe()
        print("I am a professor in the \(faculty) faculty.")
    }
}



// --- 4. University Struct (Updated) ---
struct University {
    let name: String
    let location: String

    // Memberwise Initializer (Provided by Swift automatically for structs if no custom initializers are defined).
    // Swift will now automatically generate:
    // init(name: String, location: String)

    func displayInfo() {
        print("University: \(name), Location: \(location)")
    }
}

