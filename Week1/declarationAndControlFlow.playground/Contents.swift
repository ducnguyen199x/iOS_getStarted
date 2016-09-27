//: Playground - noun: a place where people can play

print("Hello, world!")

var myVariable = 42 //myVariable is int type because initiatial value is int (42)
let myConstant = 42 //'let' is used to declared contstant
let floatConstan: Float = 4 // intiatial value does not provide enough info --> use ": <type>"

let label = "The width is "
let width = 94
let widthLabel = label + String(width) //“Values are never implicitly converted to another type”
print(widthLabel)

let valueInString = "Width is \(width)" //use \() to include value in String
print(valueInString)

//Array
var shoppingArray = ["catfish", "water", "tulips", "blue paint"]
print(shoppingArray)
shoppingArray[0] = "dog" // change array value
print(shoppingArray)

//Empty array
let emptyArray = [String]()
shoppingArray = []
shoppingArray.append("a")//add new element to array
print(shoppingArray)

//Dictionary
var occupations = [
    "Malcolm": "Captain",
    "Kaylee": "Mechanic",
]
print(occupations)
occupations["Malcolm"] = "Doctor" //change dictionary value
print(occupations)

//Empty Dictionary
let emptyDictionary = [String: Float]()
occupations = [:]
occupations["NewKey"] = "NewValue"// add new element to dict
print(occupations)

print(emptyDictionary)

//For loop
let individualScores = [75, 43, 103, 87, 12]
for score in individualScores { //for item in array
    if score > 50 {
        print(score)
    }
}

var total = 0
for i in 0..<4 { // i = 0,1,2,3
    total += 1
}
print(total)



//optional value
var optionalString: String? = "Hello"
print(optionalString == nil)

var optionalName: String? = nil// ? --> work with value that might be missing
var greeting = "Hello!"
if let name = optionalName { // if name is not missing
    greeting = "Hello, \(name)"
}
else{ // if name is missing
    greeting  = "Hello, Anonymous"
}

print(greeting)


// default value
let nickName: String? = nil
let fullName: String = "John Appleseed"
let informalGreeting = "Hi \(nickName ?? fullName)"// if nickname is missing, use fullname

print(informalGreeting)

//switch
let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"): //matched pattern
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}


//for <key,value>
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (kind, numbers) in interestingNumbers { // loop to each key-value pair in dict
    for number in numbers { //loop to each element in value
        if number > largest {
            largest = number
        }
    }
    print(kind)
}
print(largest)


//while & repeat
var n = 2
while n < 100 {
    n = n * 2
}
print(n)

var m = 2
repeat {
    m = m * 2
} while m < 100
print(m)
