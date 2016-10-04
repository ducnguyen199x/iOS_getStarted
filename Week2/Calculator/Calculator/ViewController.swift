//
//  ViewController.swift
//  Calculator
//
//  Created by Nguyen Thanh Duc on 10/4/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var resultLabel: UILabel!
  @IBOutlet var buttonDivide: UIButton!
  @IBOutlet var buttonMultiply: UIButton!
  @IBOutlet var buttonMinus: UIButton!
  @IBOutlet var buttonAdd: UIButton!


  @IBAction func buttonNumberClicked(_ sender: UIButton) {
    if let validText = resultLabel.text, let senderText = sender.titleLabel?.text {
      resultLabel.text = validText + senderText
    }
  }
  
  
  @IBAction func buttonDotClicked(_ sender: AnyObject) {
    let numberString = resultLabel.text!
    guard numberString != "" && !numberString.contains(".") else { return }
    
    resultLabel.text = numberString + "."
  }
  
  @IBAction func buttonCClicked(_ sender: AnyObject) {
    resetAllButtons()
    resultLabel.text = ""
  }
  
  @IBAction func buttonPositiveOrNegativeClicked(_ sender: AnyObject) {
    var numberString = resultLabel.text!
    guard numberString != "" else { return }
    
    if numberString.contains("-") {
      numberString.remove(at: resultLabel.text!.startIndex)
    }else {
      resultLabel.text = "-" + numberString
    }
  }
  
  @IBAction func buttonPercentageClicked(_ sender: AnyObject) {
    guard let numberString = resultLabel.text else {
      return
    }

    let result = Double(numberString)! / 100
    resultLabel.text = String(result)
    
  }
  
  @IBAction func buttonEqualClicked(_ sender: AnyObject) {
    
  }
  
  @IBAction func buttonAddClicked(_ sender: AnyObject) {
    resetAllButtons()
    buttonAdd.titleLabel?.textColor = UIColor.red
  }
  
  @IBAction func buttonMinusClicked(_ sender: AnyObject) {
    resetAllButtons()
    buttonMinus.titleLabel?.textColor = UIColor.red
  }
  
  @IBAction func buttonMutiplyClicked(_ sender: AnyObject) {
    resetAllButtons()
    buttonMultiply.titleLabel?.textColor = UIColor.red
  }
  
  @IBAction func buttonDivideClicked(_ sender: AnyObject) {
    resetAllButtons()
    buttonDivide.titleLabel?.textColor = UIColor.red
  }
  

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

//MARK: Utility
extension ViewController {
  //Reset all buttons
  func resetAllButtons() {
    buttonDivide.titleLabel?.textColor = UIColor.white
    buttonAdd.titleLabel?.textColor = UIColor.white
    buttonMultiply.titleLabel?.textColor = UIColor.white
    buttonMinus.titleLabel?.textColor = UIColor.white
  }
}

