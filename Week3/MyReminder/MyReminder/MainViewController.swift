//
//  ViewController.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/12/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Darwin
enum ThemeColor {
  case red, green, blue
  func color() -> UIColor {
    switch self {
    case .red:
      return UIColor.red
    case .green:
      return UIColor.green
    case .blue:
      return UIColor.blue
    }
  }
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var remindersArray: [Reminder] = [Reminder.init(title: "Reminder\nReminder\nReminder"),
                                    Reminder.init(title: "AAA")]
  var themeColor = ThemeColor.blue
  var selectedRowIndex: Int?
  var isShowCompleted = false
  var selectedIndex = 0
  
  @IBOutlet var myTableView: UITableView!
  @IBOutlet var numberOfRemindersLabel: UILabel!
  @IBOutlet var editButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    myTableView.allowsSelection = false
    myTableView.estimatedRowHeight = 40
    myTableView.rowHeight = UITableViewAutomaticDimension
    remindersArray[1].isCompleted = false
    updateNumberOfReminders()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: true)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
   
  }
  
  //Send data to next View
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationViewController = segue.destination as! DetailsViewController
    destinationViewController.selectedIndex = selectedIndex
    destinationViewController.titleString = remindersArray[selectedIndex].title
    destinationViewController.date = remindersArray[selectedIndex].remindDay
    destinationViewController.isRemindOnDay = remindersArray[selectedIndex].willRemindByDay
    destinationViewController.isRemindAtLocation = remindersArray[selectedIndex].willRemindAtLocation
    destinationViewController.priority = remindersArray[selectedIndex].priority
    destinationViewController.note = remindersArray[selectedIndex].note
    destinationViewController.delegate = self
  }

  //MARK: Table View
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return remindersArray.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! ReminderCell
    cell.titleTextView.delegate = self
    cell.titleTextView.tag = indexPath.row
    
    if indexPath.row < remindersArray.count {
      cell.completedButton.setTitle(nil, for: .normal)
      cell.completedButton.isEnabled = true
      cell.completedButton.borderWidth = 0.5
      cell.titleTextView.text = remindersArray[indexPath.row].title
      cell.completedButton.isSelected = remindersArray[indexPath.row].isCompleted
      cell.completedButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
      cell.completedButton.layer.cornerRadius = 10
      cell.completedButton.clipsToBounds = true
      cell.completedButton.setBackgroundColor(color: themeColor.color(), forState: .selected)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! ReminderCell
    if indexPath.row > remindersArray.count - 1 {
      createReminder(title: cell.titleTextView.text)
    } else if cell.titleTextView.text != "" {
      remindersArray[indexPath.row].title = cell.titleTextView.text
    }
    selectedIndex = indexPath.row
    self.performSegue(withIdentifier: "showDetailsView", sender: self)
    
  }
 
  
  //MARK: Button Action
  @IBAction func editButtonPressed(_ sender: UIButton) {
    
    sender.isSelected = !sender.isSelected
  }
  
  @IBAction func completedButtonPressed(_ sender: RadioButton) {
    sender.isSelected = !sender.isSelected
  }

  @IBAction func showButtonPressed(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
  }
}

//MARK: Utility
extension MainViewController {
  func updateNumberOfReminders() {
    numberOfRemindersLabel.text = remindersArray.count.description
  }
  
  func createReminder(title: String) {
    let newReminder = Reminder.init(title: title)
    remindersArray.append(newReminder)
  }
}

//MARK: UITextViewDelegate
extension MainViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    let cell = myTableView.cellForRow(at: IndexPath(row: textView.tag, section: 0))
    if textView.tag > remindersArray.count - 1 {
      if textView.text != "" {
        cell?.accessoryType = .detailButton
      } else {
        cell?.accessoryType = .none
      }
    }
    myTableView.beginUpdates()
    myTableView.endUpdates()
  }
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    let cell = myTableView.cellForRow(at: IndexPath(row: textView.tag, section: 0))
    if textView.tag <= remindersArray.count - 1 {
      cell?.accessoryType = .detailButton
    }
    editButton.isSelected = true
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    let cell = myTableView.cellForRow(at: IndexPath(row: textView.tag, section: 0))
    cell?.accessoryType = .none
    if textView.tag > remindersArray.count - 1 {
      createReminder(title: textView.text)
    } else if textView.text != "" {
      remindersArray[textView.tag].title = textView.text
    }
    myTableView.reloadData()
  }
}

//MARK: DetailsViewDelegate
extension MainViewController: DetailsViewDelegate {
  func saveDetails(index: Int, title: String, willRemindByDay: Bool, willRemindAtLocation: Bool,
                   repeatedTime: Int, note: String?,remindDay: Date?, priority: Int) {
    remindersArray[index].title = title
    remindersArray[index].willRemindByDay = willRemindByDay
    remindersArray[index].willRemindAtLocation = willRemindAtLocation
    remindersArray[index].repeatedTime = repeatedTime
    remindersArray[index].note = note
    remindersArray[index].remindDay = remindDay
    remindersArray[index].priority = priority
    myTableView.reloadData()
  }
}




