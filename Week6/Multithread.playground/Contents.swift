//: Playground - noun: a place where people can play

import Foundation

class testOperation: Operation {
  var id: Int
  
  init(id: Int) {
    self.id = id
  }
  
  override func main() {
    print("Hello World \(id)")
  }
}

let operationQueue = OperationQueue()

for i in 0...100 {
  operationQueue.addOperation(testOperation(id: i))
}


let concurrentQueue = DispatchQueue(label: "queue", qos: .default, attributes: .concurrent, autoreleaseFrequency: .never, target: nil)

for i in 0...100 {
  concurrentQueue.sync {
    print(i)
  }
}