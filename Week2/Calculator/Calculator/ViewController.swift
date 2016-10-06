//
//  ViewController.swift
//  Calculator
//
//  Created by Nguyen Thanh Duc on 10/4/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIApplicationDelegate, HistoryViewDelegate {
  
  var firstNumber: Double = 0
  var secondNumber: Double = 0
  var expression = "no"
  var startNew = true
  let historyDefaults = UserDefaults.standard
  var historyArray = [String]()

  @IBOutlet var resultLabel: UILabel!
  @IBOutlet var expressionLabel: UILabel!
  @IBOutlet var buttonDivide: UIButton!
  @IBOutlet var buttonMultiply: UIButton!
  @IBOutlet var buttonMinus: UIButton!
  @IBOutlet var buttonAdd: UIButton!


  @IBAction func buttonNumberClicked(_ sender: UIButton) {
    if var validText = resultLabel.text, let senderText = sender.titleLabel?.text {
      if startNew {
        validText = ""
        startNew = false
      }
      if validText.characters.count < 15 {
        resultLabel.text = validText + senderText
      }
    }
  }
  
  
  @IBAction func buttonDotClicked(_ sender: AnyObject) {
    guard let numberString = resultLabel.text else { return }
    if numberString != "" && !numberString.contains(".") {
      resultLabel.text = numberString + "."
    }
  }
  
  //Button Clear
  @IBAction func buttonCClicked(_ sender: AnyObject) {
    resetAllButtons()
    resultLabel.text = ""
    expressionLabel.text = ""
    firstNumber = 0
    secondNumber = 0
    expression = "no"
  }
  
  @IBAction func buttonPositiveOrNegativeClicked(_ sender: AnyObject) {
    guard var numberString = resultLabel.text else { return }
    if numberString.characters.first == "-" {
      numberString.remove(at: numberString.startIndex)
    }else if numberString != "" {
      numberString = "-" + numberString
    }
    resultLabel.text = numberString
  }
  
  @IBAction func buttonPercentageClicked(_ sender: AnyObject) {
    guard let numberString = resultLabel.text else { return }
    guard numberString != "" else { return }
    let result = Double(numberString)! / 100
    resultLabel.text = String(result)
    
  }
  
  @IBAction func buttonEqualClicked(_ sender: AnyObject) {
    let result = calculate()
    expressionLabel.text = ""
    expression = "no"
    resultLabel.text = "\(result)"
  }
  
  @IBAction func buttonExpressionClicked(_ sender: UIButton) {
    resetAllButtons()
    firstNumber = calculate()
    sender.layer.borderWidth = 2.5
    expression = sender.titleLabel?.text ?? "no"
    resultLabel.text = ""
    expressionLabel.text = "\(firstNumber)\t\(expression)"
  }

  override func viewDidLoad() {
    historyArray = historyDefaults.stringArray(forKey: "history") ?? []
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(ViewController.enterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
  }


  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //go to historyView
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destViewController: HistoryViewController = segue.destination as! HistoryViewController
    destViewController.calculationsArray = historyArray
    destViewController.delegate = self
  }
  
  //app go to background
  func enterBackground() {
    historyDefaults.set(historyArray, forKey: "history")
  }
  
  func didClearHistory(_ array: [String]) {
    historyArray = array
  }
}

//MARK: Utility
extension ViewController {
  //Reset all buttons
  func resetAllButtons() {
    buttonDivide.layer.borderWidth = 0.5
    buttonAdd.layer.borderWidth = 0.5
    buttonMultiply.layer.borderWidth = 0.5
    buttonMinus.layer.borderWidth = 0.5
  }
  
  //Calculate
  func calculate() -> Double {
    resetAllButtons()
    guard let temp = Double(resultLabel.text!) else { return firstNumber }
    secondNumber = temp
    var result: Double = 0
    switch expression {
      case "x":
        result = firstNumber * secondNumber
      case "/":
        result = firstNumber / secondNumber
      case "+":
        result = firstNumber + secondNumber
      case "-":
        result = firstNumber - secondNumber
      default:
        result = secondNumber
    }
    if expression != "no" {
      historyArray.append("\(firstNumber) \(expression) \(secondNumber) = \(result)")
    }
    startNew = true
    expression = "no"
    return result
  }
}

