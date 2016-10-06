//Selection Sort
func selectionSort(_ array: [Int]) -> [Int] {
  guard array.count > 1 else { return array }
  var a = array
  
  for i in 0..<a.count - 1 {
    var min = i
    for j in i+1..<a.count {
      if a[j] < a[min]{
        min = j
      }
    }
    
    if i != min {
      swap(&a[i], &a[min])
    }
  }
  return a
}

let arraySelectionSort = [16, 15, 55, 21, 88, 81, 53, 22, 27, 66, 61, 106, 55]
selectionSort(arraySelectionSort)

//Insertion Sort
func insertionSort(_ array: [Int]) -> [Int] {
  guard array.count > 1 else { return array }
  var a = array
  
  for i in 1..<a.count {
    var tmp = i
    while tmp > 0 && a[tmp] < a[tmp - 1]{
      swap(&a[tmp], &a[tmp - 1])
      tmp -= 1
    }
  }
  return a
}

let arrayInsertionSort = [16, 15, 55, 21, 88, 81, 53, 22, 27, 66, 61, 106, 55]
insertionSort(arraySelectionSort)

//Quick Sort
func quickSort(_ array: [Int]) -> [Int] {
  guard array.count > 1 else { return array }
  var a = array
  
  let pivot = a[a.count/2]
  let less = a.filter { $0 < pivot } //number smaller than pivot
  let equal = a.filter { $0 == pivot } // equal to pivot
  let greater = a.filter { $0 > pivot } // bigger than pivot
  
  return quickSort(less) + equal + quickSort(greater)
}

let arrayQuickSort = [16, 15, 55, 21, 88, 81, 53, 22, 27, 66, 61, 106, 55]
quickSort(arrayQuickSort)

//Counting Sort
func countingSort(_ array: [Int]) -> [Int] {
  guard  array.count > 1 else { return }
  var a = array
  let length = array.count
  var countingArray = [Int](repeating: 0, count: array.count)
  
  for i in 0..<array.count {
    for j in i + 1..array.count
  }
  return a
}




