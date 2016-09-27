//: Playground - noun: a place where people can play

import Darwin
//Class
class Shape {
    var numberOfSides = 0
    let sideLength = 10
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    
    func calCircumference(_ sidesNum: Int) -> Int {
        return sidesNum * sideLength
    }
    
    //cannot call func 2 funcs above in here.
}

var shape = Shape()
shape.numberOfSides = 7
shape.calCircumference(shape.numberOfSides)

//init & deinit func
class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {//similar to constructor in java.
        self.name = name//'self' = 'this' in java
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
    
    func printName(){
        print(name)
    }
    deinit {//when this object is deallocated
        print("killed")
    }
}

var namedShape = NamedShape(name: "Square")
namedShape.printName()

//Subclass, override
class Square: NamedShape {//Square is subclass of superclass NamedShape
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)//use func init from superclass
        numberOfSides = 4
    }
    
    func area() ->  Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {//override method from superclass
        return "A square with sides of length \(sideLength)."
    }
}
let test = Square(sideLength: 5.2, name: "my test square")
test.area()
test.simpleDescription()
test.printName()

//Subclass Circle
class Circle: NamedShape{
    var radius: Double
    init(radius: Double, name: String){
        self.radius = radius
        super.init(name: name)
    }
    
    func area() -> Double{
        return M_PI * radius * radius
    }
    
    override func simpleDescription() -> String {
        return "A circle with radius = \(radius)."
    }
}

let circle = Circle(radius: 3, name: "cirle 1")
circle.area()
circle.simpleDescription()

//perimeter: getter and setter
class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {//getter
            return 3.0 * sideLength
        }

        set {//setter
            sideLength = newValue / 3.0
        }
    }

    override func simpleDescription() -> String {
        return "An equilateral triangle with sides of length \(sideLength)."
    }
}
var triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)//getter
triangle.perimeter = 9.9//setter
print(triangle.sideLength)


//willSet is called just before the value is stored.
//didSet is called immediately after the new value is stored.

class TriangleAndSquare {
    var triangle: EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    var square: Square {
        willSet {
            print("willSet \(square.sideLength)")
            triangle.sideLength = newValue.sideLength
        }
        didSet{
            print("didSet \(square.sideLength)")
        }
    }
    init(size: Double, name: String) {
        square = Square(sideLength: size, name: name)
        triangle = EquilateralTriangle(sideLength: size, name: name)
    }
}
var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
print(triangleAndSquare.triangle.sideLength)


let optionalSquare: Square? = Square(sideLength: 2.5, name: "optional square")
let sideLength = optionalSquare?.sideLength

