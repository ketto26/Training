
// MARK:  Task 1: Palindrome check

public func isPalindrome(input: String) -> Bool {
    let cleaned = input.lowercased().filter { $0.isLetter || $0.isNumber }
    guard cleaned.count > 1 else { return false }
    return cleaned == String(cleaned.reversed())
}
