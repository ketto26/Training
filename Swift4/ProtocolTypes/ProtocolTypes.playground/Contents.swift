
// MARK: - Task 2: Opaque and Boxed Protocol Types

import Foundation


protocol Shape {
    func area() -> Double
    func perimeter() -> Double
    var description: String { get }
}

class Circle: Shape {
    let radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    func area() -> Double {
        return Double.pi * radius * radius
    }

    func perimeter() -> Double {
        return 2 * Double.pi * radius
    }

    var description: String {
        return "Circle (radius: \(radius))"
    }
}

class Rectangle: Shape {
    let width: Double
    let height: Double

    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }

    func area() -> Double {
        return width * height
    }

    func perimeter() -> Double {
        return 2 * (width + height)
    }

    var description: String {
        return "Rectangle (width: \(width), height: \(height))"
    }
}


func generateShape() -> some Shape {

    return Circle(radius: 5.0)
}


func calculateShapeDetails(for shape: any Shape) -> (area: Double, perimeter: Double) {

    let area = shape.area()
    let perimeter = shape.perimeter()
    return (area: area, perimeter: perimeter)
}
