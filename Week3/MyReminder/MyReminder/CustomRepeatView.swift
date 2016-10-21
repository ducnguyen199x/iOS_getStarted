//
//  CustomRepeatView.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/21/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

class CustomRepeatView: UITableViewController {
  
  @IBOutlet var frequencyPicker: UIPickerView!
  
  @IBOutlet var everyPicker: UIPickerView!
  
  var isFrequencySelected = true
  var isEverySelected = true
  var frequencyArray = ["Daily", "Weekly", "Monthly", "Yearly"]
  var everyArray: [Int] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    for i in 1...999 {
      everyArray.append(i)
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    if !isFrequencySelected  && indexPath.section == 0 && indexPath.row == 1 {
      return 0
    }
    
    if !isEverySelected  && indexPath.section == 0 && indexPath.row == 3 {
      return 0
    }

    return super.tableView(tableView, heightForRowAt: indexPath)
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 && indexPath.row == 0 {
      toggleFrequencyPicker()
    } else if indexPath.section == 0 && indexPath.row == 2 {
      toggleEveryPicker()
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func toggleFrequencyPicker() {
    tableView.beginUpdates()
    isFrequencySelected = !isFrequencySelected
    tableView.endUpdates()
  }
  
  func toggleEveryPicker() {
    tableView.beginUpdates()
    isEverySelected = !isEverySelected
    tableView.endUpdates()
  }
}

// MARK: UIPickerViewDataSource
extension CustomRepeatView: UIPickerViewDataSource {
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView.tag == 1 {
      return frequencyArray.count
    } else if pickerView.tag == 2 {
      return everyArray.count
    }
    return 1
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
}

// MARK: UIPickerViewDelegate
extension CustomRepeatView: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    print(row)
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView.tag == 1 {
      return frequencyArray[row]
    } else if pickerView.tag == 2 {
      return "\(everyArray[row])"
    }
    return ""
  }
}
