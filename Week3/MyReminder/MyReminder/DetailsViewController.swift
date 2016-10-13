//
//  DetailsViewController.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/13/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewController: UITableViewController {
  var isDatePickerHidden = true
  var isRemindOnDay = true
  var isRemindAtLocation = true
  
  @IBOutlet var titleLabel: UITextView!
  @IBOutlet var datePicker: UIDatePicker!
  @IBOutlet var dateDetailsLabel: UILabel!
  @IBOutlet var remindByDaySwitch: UISwitch!
  @IBOutlet var remindAtLocationSwitch: UISwitch!
  @IBOutlet var prioritySegment: UISegmentedControl!
  @IBOutlet var noteTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "Details"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(saveReminder))
    self.navigationItem.hidesBackButton = true
    updateDatePicker()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("asd")
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if isDatePickerHidden && indexPath.section == 1 && indexPath.row == 2 {
      return 0
    } else if !isRemindOnDay && indexPath.section == 1 && indexPath.row >= 1 {
      return 0
    } else if !isRemindAtLocation && indexPath.section == 2 && indexPath.row >= 1 {
      return 0
    } else {
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 1 && indexPath.row == 1 {
      toggleDatePicker()
      tableView.deselectRow(at: indexPath, animated: true)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  //Button Pressed
  @IBAction func datePickerValueSelected(_ sender: AnyObject) {
    updateDatePicker()
  }
  
  @IBAction func remindByDaySwitched(_ sender: UISwitch) {
    isRemindOnDay = sender.isOn
    updateTableView()
  }
  
  @IBAction func remindAtLocationSwitched(_ sender: UISwitch) {
    isRemindAtLocation = sender.isOn
    updateTableView()
  }
  
  func saveReminder() {
    self.dismiss(animated: true, completion: nil)
  }
}

//MARK: Hide and Show cell
extension DetailsViewController {
  func updateTableView() {
    tableView.beginUpdates()
    tableView.endUpdates()
  }
  func toggleDatePicker() {
    isDatePickerHidden = !isDatePickerHidden
    updateTableView()
  }
  
  func updateDatePicker() {
    dateDetailsLabel.text = DateFormatter.localizedString(from: datePicker.date, dateStyle: .short, timeStyle: .short)
  }
}
