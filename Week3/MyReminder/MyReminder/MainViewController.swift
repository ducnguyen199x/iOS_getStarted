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
  
  var remindersArray: [Reminder] = [Reminder.init(title: "Reminder\nReminder\nReminder", willRemind: false, alarm: nil, isRepeated: nil, note: nil),
                                    Reminder.init(title: "AAA", willRemind: false, alarm: nil, isRepeated: nil, note: nil)]
  var themeColor = ThemeColor.blue
  var selectedRowIndex: Int?
  var isShowCompleted = false
  let myStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
  var detailsViewSegue: UIStoryboardSegue? = nil
  var detailsViewController: UIViewController? = nil
  
  @IBOutlet var myTableView: UITableView!
  @IBOutlet var numberOfRemindersLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    detailsViewController = myStoryboard.instantiateViewController(withIdentifier: "DetailsViewController")
    if let detailsViewController = detailsViewController {
      detailsViewSegue = UIStoryboardSegue.init(identifier: "showDetailsView", source: self, destination: detailsViewController)
    }
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
    print("Here")
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
    navigationController?.performSegue(withIdentifier: "showDetailsView", sender: self)
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




