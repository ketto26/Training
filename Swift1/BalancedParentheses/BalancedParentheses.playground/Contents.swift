
// MARK: - Task 2: BalancedParentheses

public func isBalancedParentheses(input: String) -> Bool {
    var count = 0
    for c in input where c == "(" || c == ")" {
        count += (c == "(") ? 1 : -1
        if count < 0 { return false }
    }
    return count == 0
}
