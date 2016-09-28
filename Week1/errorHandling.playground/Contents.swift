//ERROR HANDLING
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}


//throws: mark func that can throw an error
func send(job: Int, toPrinter printerName: String) throws -> String {
    if printerName == "Never Has Toner" {
        throw PrinterError.noToner //throw to throw an error
    }
    else if printerName == "Fire"{
        throw PrinterError.onFire
    }
    else if printerName == "No more paper"{
        throw PrinterError.outOfPaper
    }
    defer {
        print("Always print")
    }
    return "Job sent"
}

//do-catch
do {
    let printerResponse = try send(job: 1040, toPrinter: "Bi Sheng")
    
    try send(job: 1000, toPrinter: "Never Has Toner")
} catch {
    print(error)
}

//multiple catch blocks
do {
    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
    print(printerResponse)
    try send(job: 1000, toPrinter: "No more paper")
    //try send(job: 1001, toPrinter: "Never Has Toner")
    //try send(job: 1002, toPrinter: "Fire")
} catch PrinterError.onFire {
    print("I'll just put this over here, with the rest of the fire.")
} catch let printerError as PrinterError {
    print("Printer error: \(printerError).")
} catch {
    print(error)
}

//Handle error with "try?"
let printerSuccess = try? send(job: 1884, toPrinter: "Mergenthaler")//no error
let printerFailure = try? send(job: 1885, toPrinter: "Never Has Toner")//error then assign to nil


//defer: is executed regardless of whether the function throws an error
var fridgeIsOpen = false
let fridgeContent = ["milk", "eggs", "leftovers"]

func fridgeContains(_ food: String) -> Bool {
    fridgeIsOpen = true
    defer {//is always executed
        fridgeIsOpen = false
    }
    
    let result = fridgeContent.contains(food)
    return result
}
fridgeContains("banana")
print(fridgeIsOpen)


//GENERICS
func makeArray<A>(repeating item: A, numberOfTimes: Int) -> [A] {
    var result = [A]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}
makeArray(repeating: "knock", numberOfTimes:4)

// Reimplement the Swift standard library's optional type
enum OptionalValue<Wrapped> {
    case none
    case some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .none
possibleInteger = .some(100)


//where clause
func anyCommonElements<T: Sequence, U: Sequence>(_ lhs: T, _ rhs: U) -> Array<T.Iterator.Element>
    where T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element {
        var result = Array<T.Iterator.Element>()
        for lhsItem in lhs {
            for rhsItem in rhs {
                if lhsItem == rhsItem {
                    result.append(lhsItem)
                }
            }
        }
        return result
}
anyCommonElements([1, 2, 3], [2, 3])



