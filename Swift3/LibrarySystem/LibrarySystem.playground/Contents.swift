
// MARK: - Task 1: Library Management System

import Foundation

// 1. Define a protocol Borrowable
protocol Borrowable {
    var borrowDate: Date? { get set }
    var returnDate: Date? { get set }
    var isBorrowed: Bool { get set }
    
    mutating func checkIn()
}

// 2. Provide a default implementation for Borrowable (via protocol extension)
extension Borrowable {
    func isOverdue() -> Bool {
        guard let returnDate = returnDate, isBorrowed else {
            return false
        }
        return returnDate < Date()
    }
    
    mutating func checkIn() {
        borrowDate = nil
        returnDate = nil
        isBorrowed = false
        print("Item has been checked in and is now available.")
    }
}

// 3. Create Classes
// Item Class (Base class)
class Item {
    let id: String
    let title: String
    let author: String
    
    init(id: String, title: String, author: String) {
        self.id = id
        self.title = title
        self.author = author
    }
}

// Book Subclass
class Book: Item, Borrowable {
    // Borrowable properties
    var borrowDate: Date?
    var returnDate: Date?
    var isBorrowed: Bool = false
    
    // Initializer for Book, calling super's initializer
    init(id: String, title: String, author: String, isBorrowed: Bool = false, borrowDate: Date? = nil, returnDate: Date? = nil) {
        self.isBorrowed = isBorrowed
        self.borrowDate = borrowDate
        self.returnDate = returnDate
        super.init(id: id, title: title, author: author)
    }
}

// 4. Define an enumeration LibraryError
enum LibraryError: Error, CustomStringConvertible {
    case itemNotFound
    case itemNotBorrowable
    case alreadyBorrowed
    
    var description: String {
        switch self {
        case .itemNotFound:
            return "Error: The item with the specified ID was not found."
        case .itemNotBorrowable:
            return "Error: This item is not of a borrowable type."
        case .alreadyBorrowed:
            return "Error: This item is already borrowed."
        
        }
    }
}

// 5. Create a Library class
class Library {
    private var items: [String: Item] = [:]
    
    func addBook(_ book: Book) {
        items[book.id] = book
        print("\"\(book.title)\" by \(book.author) added to the library.")
    }
    
    // 6. Implement optional chaining in borrowItem
    func borrowItem(by id: String) throws -> Item {
        guard let item = items[id] else {
            throw LibraryError.itemNotFound
        }
        
        guard var borrowableItem = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        
        if borrowableItem.isBorrowed {
            throw LibraryError.alreadyBorrowed
        }
        
        borrowableItem.isBorrowed = true
        borrowableItem.borrowDate = Date()
        borrowableItem.returnDate = Calendar.current.date(byAdding: .day, value: 14, to: Date())
        

        print("\"\(item.title)\" has been borrowed. Due back on: \(borrowableItem.returnDate!)")
        return item
    }

    func returnItem(by id: String) throws {
        guard let item = items[id] else {
            throw LibraryError.itemNotFound
        }

        guard var borrowableItem = item as? Borrowable else {
            throw LibraryError.itemNotBorrowable
        }
        
        borrowableItem.checkIn()
        print("\"\(item.title)\" has been returned.")
    }

    func displayItemStatus(id: String) {
        guard let item = items[id] else {
            print("Item with ID \(id) not found.")
            return
        }

        print("\n--- Status for '\(item.title)' ---")
        if let borrowableItem = item as? Borrowable {
            print("Is Borrowed: \(borrowableItem.isBorrowed)")
            if let borrowDate = borrowableItem.borrowDate {
                print("Borrowed On: \(borrowDate)")
            }
            if let returnDate = borrowableItem.returnDate {
                print("Return By: \(returnDate)")
            }
            print("Is Overdue: \(borrowableItem.isOverdue())")
        } else {
            print("This item is not borrowable.")
        }
    }
}
