
// MARK: - Task 3: Higher Order Functions

import Foundation

// 1. Array of dictionaries.
let books: [[String: Any]] = [
    ["title": "Swift Fundamentals", "author": "John Doe", "year": 2015, "price": 40, "genre": ["Programming", "Education"]],
    ["title": "The Great Gatsby", "author": "F. Scott Fitzgerald", "year": 1925, "price": 15, "genre": ["Classic", "Drama"]],
    ["title": "Game of Thrones", "author": "George R. R. Martin", "year": 1996, "price": 30, "genre": ["Fantasy", "Epic"]],
    ["title": "Big Data, Big Dupe", "author": "Stephen Few", "year": 2018, "price": 25, "genre": ["Technology", "Non-Fiction"]],
    ["title": "To Kill a Mockingbird", "author": "Harper Lee", "year": 1960, "price": 20, "genre": ["Classic", "Drama"]],
]

// 2. Define discountedPrices (Array<Double>) with a 10% discount.
let discountedPrices: [Double] = books.compactMap { book -> Double? in
    guard let price = book["price"] as? Int else {
        return nil
    }
    // Calculate discounted price and return it
    return Double(price) * 0.90
}

// 3. Define booksPostedAfter2000 (Array<String>) for books published after 2000.
// First, filter by year, then map to titles.
let booksPostedAfter2000: [String] = books.filter { book -> Bool in
    guard let year = book["year"] as? Int else {
        return false
    }
    return year > 2000
}.compactMap { book -> String? in
    return book["title"] as? String
}

// 4. Define allGenres (Set<String>) for all unique genres.
// Use flatMap to get all genre arrays and flatten them, then convert to Set.
let allGenres: Set<String> = Set(
    books.flatMap { book -> [String] in
        return book["genre"] as? [String] ?? []
    }
)

// 5. Define totalCost (Int) for one instance of each book.
// First, get all valid prices using compactMap, then reduce them.
let totalCost: Int = books.compactMap { book -> Int? in
    return book["price"] as? Int
}.reduce(0, +) // 0 is the initial sum, + is the combining operation
