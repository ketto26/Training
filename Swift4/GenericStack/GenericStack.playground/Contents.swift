
// MARK: - Task 1: Generic Stack

import Foundation


class Stack<T> {
    fileprivate var items: [T] = []

    func push(_ element: T) {
        items.append(element)
    }

    func pop() -> T? {
        return items.popLast()
    }

    func size() -> Int {
        return items.count
    }

    var isEmpty: Bool {
        return items.isEmpty
    }
    
    func peek() -> T? {
        return items.last
    }
}

func printStackContents<T>(_ stack: Stack<T>) -> String {
    guard !stack.items.isEmpty else {
        return "Stack is empty."
    }

    let description = stack.items.reversed().map { "\($0)" }.joined(separator: " -> ")
    return "Stack (Top to Bottom): [ \(description) ]"
}
