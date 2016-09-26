//: Playground - noun: a place where people can play


//Simple function with 2 parameters and return String
func greet(person: String, lunch: String) -> String { //person and lunch are labels
    return "Hello \(person), today lunch special is \(lunch)."
}

greet(person: "Bob", lunch: "Fish")


//'_' indicates no label, 'on' is label of parameter 'day'
func greet(_ person: String, on day: String) -> String {
return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")

//function returning tuple
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }
    
    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)

//function takes a variable number of arguments, collecting them into an array
func sumOf(list numbers: Int...) -> Int {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return sum
}
sumOf()
sumOf(list: 42, 597, 12)

//function to calculate average of its arguments
func averageOf(list numbers: Int...) -> Int{
    var sum = 0
    for number in numbers{
        sum += number
    }
    return (sum / numbers.count) //numbers.count = size of numbers
}

averageOf(list: 5,10,15)


//Nested function
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()


//first-class type -> func return another func
func makeIncrementer() -> ((Int) -> Int) {
    func addOne(number: Int) -> Int {
        return 1 + number
    }
    return addOne
}
var increment = makeIncrementer()
increment(7)

func test(array: [Int]) -> Int{
    return array[0]
}

func nestedFunc(numbers: Int...) -> Int {
    return test(array: numbers)
    
}

nestedFunc(numbers: 1,2,3)

