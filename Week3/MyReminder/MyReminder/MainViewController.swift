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
  
  var remindersArray: [Reminder] = [Reminder(title: "Reminder")]
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
  
  // Send data to next View
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let destinationViewController = segue.destination as! DetailsViewController
    destinationViewController.selectedIndex = selectedIndex
//    destinationViewController.titleString = remindersArray[selectedIndex].title
//    destinationViewController.date = remindersArray[selectedIndex].remindDay
//    destinationViewController.isRemindOnDay = remindersArray[selectedIndex].willRemindByDay
//    destinationViewController.isRemindAtLocation = remindersArray[selectedIndex].willRemindAtLocation
//    destinationViewController.priority = remindersArray[selectedIndex].priority
//    destinationViewController.note = remindersArray[selectedIndex].note
    destinationViewController.delegate = self
    destinationViewController.reminder = remindersArray[selectedIndex]
  }

  // MARK: Table View
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if editButton.isSelected {
      return remindersArray.count
    } else {
      return remindersArray.count + 1
    }
    //return remindersArray.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! ReminderCell
    cell.titleTextView.delegate = self
    cell.titleTextView.tag = indexPath.row
    cell.layer.borderWidth = 0
    cell.completedButton.isEnabled = false
    cell.completedButton.setTitle("+", for: .normal)
    cell.titleTextView.text = ""
    
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
  
  // Accessory tapped
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
 
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    tableView.beginUpdates()
    tableView.deleteRows(at: [indexPath], with: .automatic)
    remindersArray.remove(at: indexPath.row)
    tableView.endUpdates()
  }
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  // Reorder rowjhj
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedItem = remindersArray[sourceIndexPath.row]
    remindersArray.remove(at: sourceIndexPath.row)
    remindersArray.insert(movedItem, at: destinationIndexPath.row)
  }
  
  // MARK: Button Action
  @IBAction func editButtonPressed(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    myTableView.isEditing = !myTableView.isEditing
    myTableView.reloadData()
    //myTableView.reloadRows(at: [IndexPath(row: remindersArray.count, section: 0)], with: .automatic)
  }
  
  @IBAction func completedButtonPressed(_ sender: RadioButton) {
    sender.isSelected = !sender.isSelected
  }

  @IBAction func showButtonPressed(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
  }
}

// MARK: Utility
extension MainViewController {
  func updateNumberOfReminders() {
    numberOfRemindersLabel.text = remindersArray.count.description
  }
  
  func createReminder(title: String) {
    let newReminder = Reminder.init(title: title)
    remindersArray.append(newReminder)
    myTableView.insertRows(at: [IndexPath(row:remindersArray.count - 1, section: 0)], with: .automatic)
    myTableView.reloadRows(at: [IndexPath(row: remindersArray.count, section: 0)], with: .automatic)
  }
}

// MARK: UITextViewDelegate
extension MainViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    let cell = myTableView.cellForRow(at: IndexPath(row: textView.tag, section: 0))
    
    // Hide/Show accessory of the last row
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
    
    // Show accessory when textview is focused
    if textView.tag <= remindersArray.count - 1 {
      cell?.accessoryType = .detailButton
    }
    //editButton.isSelected = true
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    let cell = myTableView.cellForRow(at: IndexPath(row: textView.tag, section: 0))
    cell?.accessoryType = .none
    
    // Create/Save reminder when textview is end editted
    if textView.text != "" {
      if textView.tag > remindersArray.count - 1 {
        createReminder(title: textView.text)
      } else {
        remindersArray[textView.tag].title = textView.text
      }
    }
    //myTableView.reloadData()
  }
}

// MARK: DetailsViewDelegate
extension MainViewController: DetailsViewDelegate {
  func saveDetails(index: Int) {
//    remindersArray[index].title = title
//    remindersArray[index].willRemindByDay = willRemindByDay
//    remindersArray[index].willRemindAtLocation = willRemindAtLocation
//    remindersArray[index].repeatedTime = repeatedTime
//    remindersArray[index].note = note
//    remindersArray[index].remindDay = remindDay
//    remindersArray[index].priority = priority
    myTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
  }
}




