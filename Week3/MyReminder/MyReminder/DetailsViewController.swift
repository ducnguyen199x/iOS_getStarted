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
  var selectedIndex = 0
  var isDatePickerHidden = true
  var delegate: DetailsViewDelegate?
  var reminder: Reminder?
  
  @IBOutlet var titleTextView: UITextView!
  @IBOutlet var datePicker: UIDatePicker!
  @IBOutlet var dateDetailsLabel: UILabel!
  @IBOutlet var remindByDaySwitch: UISwitch!
  @IBOutlet var remindAtLocationSwitch: UISwitch!
  @IBOutlet var prioritySegment: UISegmentedControl!
  @IBOutlet var noteTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleTextView.text = reminder?.title
    remindByDaySwitch.isOn = reminder?.willRemindByDay ?? false
    remindAtLocationSwitch.isOn = reminder?.willRemindAtLocation ?? false
    noteTextView.text = reminder?.note
    prioritySegment.selectedSegmentIndex = reminder?.priority ?? 0
    if let date = reminder?.remindDay {
      datePicker.date = date
    }
    self.navigationItem.title = "Details"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Done", style: .plain, target: self, action: #selector(saveReminder))
    self.navigationItem.hidesBackButton = true
    updateDatePicker()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    print("Change")
  }
  
  //TableView functions
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if isDatePickerHidden && indexPath.section == 1 && indexPath.row == 2 {
      return 0
    } else if !(reminder?.willRemindByDay)! && indexPath.section == 1 && indexPath.row >= 1 {
      return 0
    } else if !(reminder?.willRemindAtLocation)! && indexPath.section == 2 && indexPath.row >= 1 {
      return 0
    } else if indexPath.section == 1 && indexPath.row == 2 {
      return super.tableView(self.tableView, heightForRowAt: indexPath)
    } else {
        return UITableViewAutomaticDimension
    }
  }
  
  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
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
    reminder?.willRemindByDay = sender.isOn
    updateTableView()
  }
  
  @IBAction func remindAtLocationSwitched(_ sender: UISwitch) {
    reminder?.willRemindAtLocation = sender.isOn
    updateTableView()
  }
  
  func saveReminder() {
    reminder?.save(title: titleTextView.text, willRemindByDay: remindByDaySwitch.isOn, willRemindAtLocation: remindAtLocationSwitch.isOn, repeatedTime: 0, note: noteTextView.text, remindDay: datePicker.date, priority: prioritySegment.selectedSegmentIndex)
    delegate?.saveDetails(index: selectedIndex)
    _ = self.navigationController?.popToRootViewController(animated: true)
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

//MARK: UITextViewDelegate
extension DetailsViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    if titleTextView.text == "" {
      self.navigationItem.rightBarButtonItem?.isEnabled = false
    } else {
      self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    tableView.beginUpdates()
    tableView.endUpdates()
  }
}
