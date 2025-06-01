
// MARK: - Task 2: Type Casting and Nested Types in a School System

import Foundation

// 1. Define a struct called School
struct School {
    // 2. Inside School, create a nested enum SchoolRole
    enum SchoolRole {
        case student, teacher, administrator
    }

    // 3. Define a nested class within School called Person
    class Person {
        let name: String
        let role: SchoolRole

        init(name: String, role: School.SchoolRole) {
            self.name = name
            self.role = role
        }
    }

    // Private storage for all people in the school
    private var allPeople: [Person] = []

    // Define new method in School addPerson(_ :)
    mutating func addPerson(_ person: Person) {
        allPeople.append(person)
        print("\(person.name) (\(person.role)) has been added to the school.")
    }
    
    // Implement a subscript in School to retrieve arrays of Person objects
    subscript(role: SchoolRole) -> [Person] {
        return allPeople.filter { $0.role == role }
    }
}

// Create three functions: countStudents, countTeachers, and countAdministrators
func countStudents(in school: School) -> Int {
    // Use the school's subscript to get students
    return school[.student].count
}

func countTeachers(in school: School) -> Int {
    // Use the school's subscript to get teachers
    return school[.teacher].count
}

func countAdministrators(in school: School) -> Int {
    // Use the school's subscript to get administrators
    return school[.administrator].count
}
