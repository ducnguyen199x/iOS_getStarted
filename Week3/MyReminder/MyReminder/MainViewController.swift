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
    return remindersArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! ReminderCell
    
    cell.titleTextView.text = remindersArray[indexPath.row].title
    cell.titleTextView.delegate = self
    cell.completedButton.isSelected = remindersArray[indexPath.row].isCompleted
    cell.completedButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    cell.completedButton.layer.cornerRadius = 10
    cell.completedButton.clipsToBounds = true
    cell.completedButton.setBackgroundColor(color: themeColor.color(), forState: .selected)
    cell.titleTextView.tag = indexPath.row
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    self.performSegue(withIdentifier: "showDetailsView", sender: self)
    selectedIndex = indexPath.row
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
}

//MARK: UITextViewDelegate
extension MainViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    myTableView.beginUpdates()
    myTableView.endUpdates()
  }
  
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    let cell = myTableView.cellForRow(at: IndexPath(row: textView.tag, section: 0))
    cell?.accessoryType = .detailButton
    return true
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    let cell = myTableView.cellForRow(at: IndexPath(row: textView.tag, section: 0))
    cell?.accessoryType = .none
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




