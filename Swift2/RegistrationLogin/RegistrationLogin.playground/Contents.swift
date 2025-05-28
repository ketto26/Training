// MARK: - Task1: User Registration and Login System

import Foundation


// MARK: - Step 1: Define User struct
struct User {
    // Stored properties
    let username: String
    let email: String
    private(set) var password: String // password is read-only from outside

    // Custom initialiser with password hashing
    init(username: String, email: String, password: String) {
        self.username = username
        self.email = email
        self.password = User.hash(password)
    }

    // Simulated password hashing (simple reversal)
    static func hash(_ password: String) -> String {
        return String(password.reversed())
    }

    // Verifies user input against stored (hashed) password
    func verifyPassword(_ input: String) -> Bool {
        return password == User.hash(input)
    }
}


// MARK: - Step 2: UserManager class with stored property, methods, computed property
class UserManager {
    // Stored property: Dictionary to store users by username
    fileprivate var users: [String: User] = [:]
    
    // Designated initializer
    init(users: [String: User] = [:]) {
            self.users = users
        }

    // Method to register new users
    func registerUser(username: String, email: String, password: String) -> Bool {
        // Ensure username is unique
        guard users[username] == nil else {
            print("⚠️ Username already exists.")
            return false
        }
        
        // Create and store new user
        let newUser = User(username: username, email: email, password: password)
        users[username] = newUser
        print("✅ User registered: \(username)")
        return true
    }

    // Method to log in by verifying credentials
    func login(username: String, password: String) -> Bool {
        guard let user = users[username] else {
            print("❌ User not found.")
            return false
        }
        if user.verifyPassword(password) {
            print("✅ Login successful for \(username)")
            return true
        } else {
            print("❌ Incorrect password for \(username)")
            return false
        }
    }

    // Method to remove user by username
    func removeUser(username: String) -> Bool {
        if users.removeValue(forKey: username) != nil {
            print("❌ User removed: \(username)")
            return true
        } else {
            print("⚠️ User \(username) does not exist.")
            return false
        }
    }
    
    // Computed property to return total number of registered users
    var userCount: Int {
        return users.count
    }
}


// MARK: - Step 3 & 5: AdminUser subclass + deinit
class AdminUser: UserManager {
    // Method to list all usernames alphabetically
    func listAllUsers() -> [String] {
        return users.keys.sorted()
    }
    
    // Step 5: Deinitializer to clean up and print message
    deinit {
        print("🧹 AdminUser instance is being deinitialized.")
    }
}
