//
//  ViewController.swift
//  MyPickerView
//
//  Created by Nguyen Thanh Duc on 10/20/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var fahrenheitLabel: UILabel!
  @IBOutlet var celsiusPickerView: UIPickerView!
  
  var celsiusArray: [Int] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    for i in -100...100 {
      celsiusArray.append(i)
    }
    celsiusPickerView.selectRow(celsiusArray.count/2, inComponent: 0, animated: true)
    convertCelsiustoFahrenheit(celsiusValue: celsiusArray[celsiusPickerView.selectedRow(inComponent: 0)])
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // convert C to F and display on label
  func convertCelsiustoFahrenheit(celsiusValue: Int) {
    let fahrenheitValue = Double(celsiusValue) * 1.8 + 32
    
    let fahrenheitValueString = NSMutableAttributedString(string: "\(fahrenheitValue)", attributes: [NSForegroundColorAttributeName: UIColor.white])
    let fahrenheitSign = NSAttributedString(string: "°F", attributes: [NSForegroundColorAttributeName: UIColor.green])
    fahrenheitValueString.append(fahrenheitSign)
    fahrenheitLabel.attributedText = fahrenheitValueString
  }
}

// MARK: UIPickerViewDataSource
extension ViewController: UIPickerViewDataSource {
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return celsiusArray.count
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
}

// MARK: UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    let celsiusComponent = "\(celsiusArray[row])"
    
    let celsiusValueString = NSMutableAttributedString(string: celsiusComponent, attributes: nil)
    let celsiusSign = NSAttributedString(string: "°C", attributes: [NSForegroundColorAttributeName: UIColor.red])
    celsiusValueString.append(celsiusSign)
    
    return celsiusValueString
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    convertCelsiustoFahrenheit(celsiusValue: celsiusArray[row])
  }
}
