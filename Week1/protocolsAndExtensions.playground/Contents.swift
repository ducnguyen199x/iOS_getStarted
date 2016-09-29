
//Protocols (similar to Abstract class in java)
protocol ExampleProtocol {
  var simpleDescription: String { get }
  mutating func adjust() // mutating func changes the value of the variables in this structure or class
}

//Protocol for class
class SimpleClass: ExampleProtocol {
  var simpleDescription: String = "A very simple class."
  var anotherProperty: Int = 69105
  func adjust() {//class cannot use keyword 'mutating' before 'func'
    simpleDescription += "  Now 100% adjusted."
  }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

//Protocol for struct
struct SimpleStructure: ExampleProtocol {
  var simpleDescription: String = "A simple structure"
  mutating func adjust() { //struct must use keyword 'mutating' to implement mutating func of its protocol
    simpleDescription += " (adjusted)"
  }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

//Protocol for enum
enum SimpleEnum: ExampleProtocol{
  case a, b, c
  
  var simpleDescription: String {
    switch self {
    case .a:
      return "This is a"
    case .b:
      return "This is b"
    case .c:
      return "This is c"
    }
  }
  
  mutating func adjust() {
    switch self {
    case .a:
      self = .b
    case .b:
      self = .c
    case . c:
      self = .a
    }
  }
}

var simpleEnum = SimpleEnum.a
simpleEnum.simpleDescription
simpleEnum.adjust()
simpleEnum.simpleDescription

//Extension: to add functionality to an existing type
extension Int: ExampleProtocol {
  var simpleDescription: String {
    return "The number \(self)"
  }
  mutating func adjust() {
    self += 42
  }
}
print(7.simpleDescription)
var intTest = 1
intTest.simpleDescription
intTest.adjust()
intTest.simpleDescription

//Extension for the Double type
extension Double: ExampleProtocol {
  var simpleDescription: String {
    return "The number (double) \(self)"
  }
  var absValue: Double {
    return abs(self)
  }
  mutating func adjust() {
    self = absValue
  }
}

var doubleTest = -2.6
doubleTest.simpleDescription
doubleTest.absValue
doubleTest.adjust()
doubleTest.simpleDescription



