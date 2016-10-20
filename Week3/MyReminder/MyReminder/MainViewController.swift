//
//  ViewController.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/12/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Darwin
import UserNotifications

enum ThemeColor {
  case red, green, blue, yellow, lightGray
  func color() -> UIColor {
    switch self {
    case .red:
      return UIColor.red
    case .green:
      return UIColor.green
    case .blue:
      return UIColor.blue
    case .yellow:
      return UIColor.yellow
    case .lightGray:
      return UIColor.lightGray
    }
  }
  
  func description() -> String {
    switch self {
    case .red:
      return "Red"
    case .green:
      return "Green"
    case .blue:
      return "Blue"
    case .yellow:
      return "Yellow"
    case .lightGray:
      return "Light Gray"
    }
  }
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  var remindersArray: [Reminder] = []
  var themeColor = ThemeColor.blue
  var selectedRowIndex: Int?
  var isShowCompleted = false
  var selectedIndex = 0
  
  @IBOutlet var showButton: UIButton!
  @IBOutlet var listLabel: UILabel!
  @IBOutlet var myTableView: UITableView!
  @IBOutlet var numberOfRemindersLabel: UILabel!
  @IBOutlet var editButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    getFileFromUserDefautls()
    setUpView()
    myTableView.register(UINib.init(nibName: "HeaderColor", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
    updateNumberOfReminders()
    //when app will be terminated
    NotificationCenter.default.addObserver(self, selector: #selector(saveFileToUserDefaults), name: .UIApplicationWillTerminate, object: nil)
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
    if segue.identifier == "showDetailsView" {
      let destinationViewController = segue.destination as! DetailsViewController
      destinationViewController.selectedIndex = selectedIndex
      destinationViewController.delegate = self
      destinationViewController.reminder = remindersArray[selectedIndex]
    } else if segue.identifier == "showColorView" {
      let destinationViewController = segue.destination as! ColorViewController
      destinationViewController.currentColor = themeColor
      destinationViewController.delegate = self
    }
  }

  // MARK: Table View
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if myTableView.isEditing {
      return remindersArray.count
    } else {
      return remindersArray.count + 1
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return tableView.isEditing && editButton.isSelected ? 50 : 0
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    if myTableView.isEditing {
      let view = myTableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! HeaderViewController
      view.viewController = self
      return view
    } else {
      return nil
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath) as! ReminderCell
    cell.titleTextView.delegate = self
    cell.titleTextView.tag = indexPath.row
    cell.completedButton.tag = indexPath.row
    cell.toLastCellFormat()

    
    if indexPath.row < remindersArray.count {
      cell.toNormalCellFormat()
      cell.completedButton.setBackgroundColor(color: themeColor.color(), forState: .selected)
      
      var priorityString = remindersArray[indexPath.row].getPriority()
    
      let attributedString = NSMutableAttributedString.init(string: "\(priorityString)\(remindersArray[indexPath.row].title)")
      attributedString.addAttribute(NSForegroundColorAttributeName,
                                    value: themeColor.color(), range: NSRange(location: 0, length: priorityString.characters.count))
      attributedString.addAttribute(NSFontAttributeName,
                                    value: UIFont.systemFont(ofSize: 18.0), range: NSRange(location: 0, length: remindersArray[indexPath.row].title.characters.count + priorityString.characters.count))

      cell.titleTextView.attributedText = attributedString
      cell.completedButton.isSelected = remindersArray[indexPath.row].isCompleted
      
      if myTableView.isEditing {
        cell.completedButton.isEnabled = false
        cell.titleTextView.isEditable = false
      }
    }

    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row < remindersArray.count && remindersArray[indexPath.row].isCompleted && !isShowCompleted {
      return 0.1
    }
    return 40
  }

  
  //when scroll
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    if !myTableView.isEditing {
      editButton.isSelected = false
      myTableView.endEditing(true)
    }
  }
  
  // Accessory tapped
  func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! ReminderCell
    
    if indexPath.row > remindersArray.count - 1 {
      createReminder(title: cell.titleTextView.text)
    } else if cell.titleTextView.text != "" {
      let priority = remindersArray[indexPath.row].priority
      let index = cell.titleTextView.text.index(cell.titleTextView.text.startIndex, offsetBy: priority)
      remindersArray[indexPath.row].title = cell.titleTextView.text.substring(from: index)
    }
    selectedIndex = indexPath.row
    self.performSegue(withIdentifier: "showDetailsView", sender: self)
  }
 
  // commit delete
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    remindersArray[indexPath.row].cancelNotification()
    if editButton.isSelected {
      tableView.beginUpdates()
      tableView.deleteRows(at: [indexPath], with: .automatic)
      remindersArray.remove(at: indexPath.row)
      tableView.endUpdates()
    } else {
      tableView.deleteRows(at: [indexPath], with: .automatic)
      remindersArray.remove(at: indexPath.row)
    }
    updateNumberOfReminders()
  }
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    guard editButton.isSelected == false else {
      //if text view is focusing, just return
      return false
    }
    
    guard tableView.isEditing || indexPath.row != remindersArray.count else {
      return false
    }
    
    return true
  }
  
  // Reorder row
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedItem = remindersArray[sourceIndexPath.row]
    remindersArray.remove(at: sourceIndexPath.row)
    remindersArray.insert(movedItem, at: destinationIndexPath.row)
  }
  
  // MARK: Button Action
  @IBAction func editButtonPressed(_ sender: UIButton) {
    if editButton.isSelected && !myTableView.isEditing {
      myTableView.endEditing(true)
      sender.isSelected = !sender.isSelected
      return
    } else {
      showButton.isHidden = !showButton.isHidden
      sender.isSelected = !sender.isSelected
      myTableView.isEditing = !myTableView.isEditing
      myTableView.reloadData()
    }
  }
  
  @IBAction func completedButtonPressed(_ sender: RadioButton) {
    sender.isSelected = !sender.isSelected
    remindersArray[sender.tag].isCompleted = sender.isSelected
    myTableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
  }

  @IBAction func showButtonPressed(_ sender: UIButton) {
    remindersArray.sort(by: {!$0.isCompleted && $1.isCompleted})
    sender.isSelected = !sender.isSelected
    isShowCompleted = sender.isSelected
    updateNumberOfReminders()
    myTableView.reloadData()
  }
  
  func colorHeaderPressed() {
    performSegue(withIdentifier: "showColorView", sender: self)
  }
}

// MARK: Utility
extension MainViewController {
  func updateNumberOfReminders() {
    numberOfRemindersLabel.text = isShowCompleted ? remindersArray.count.description : remindersArray.filter({ !$0.isCompleted }).count.description
  }
  
  func createReminder(title: String) {
    let newReminder = Reminder.init(title: title)
    remindersArray.append(newReminder)
    myTableView.insertRows(at: [IndexPath(row:remindersArray.count - 1, section: 0)], with: .automatic)
    myTableView.reloadRows(at: [IndexPath(row: remindersArray.count, section: 0)], with: .automatic)
    numberOfRemindersLabel.text = "\(remindersArray.count)"
    updateNumberOfReminders()
  }
  
  func setUpView() {
    showButton.isSelected = isShowCompleted
    listLabel.textColor = themeColor.color()
    numberOfRemindersLabel.textColor = themeColor.color()
    myTableView.allowsSelection = false
    myTableView.estimatedRowHeight = 40
    myTableView.rowHeight = UITableViewAutomaticDimension
  }
  
  // Save/Get File UserDefaults
  func saveFileToUserDefaults() {
    let data = NSKeyedArchiver.archivedData(withRootObject: remindersArray)
    UserDefaults.standard.set(data, forKey: "Reminders")
    UserDefaults.standard.set(isShowCompleted, forKey: "isShowCompleted")
  }
  
  func getFileFromUserDefautls() {
    if let data = UserDefaults.standard.object(forKey: "Reminders") as? Data {
      remindersArray = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Reminder]
    }
    isShowCompleted = UserDefaults.standard.bool(forKey: "isShowCompleted")
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
    editButton.isSelected = true
    let cell = myTableView.cellForRow(at: IndexPath(row: textView.tag, section: 0))
    // Show accessory when textview is focused
    if textView.tag <= remindersArray.count - 1 {
      cell?.accessoryType = .detailButton
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    let cell = myTableView.cellForRow(at: IndexPath(row: textView.tag, section: 0))
    cell?.accessoryType = .none
    
    // Create/Save reminder when textview is end editted
    if textView.text != "" {
      if textView.tag > remindersArray.count - 1 {
        createReminder(title: textView.text)
      } else {
        let priority = remindersArray[textView.tag].priority
        let index = textView.text.index(textView.text.startIndex, offsetBy: priority)
        remindersArray[textView.tag].title = textView.text.substring(from: index)
      }
    }
  }
}

// MARK: DetailsViewDelegate
extension MainViewController: DetailsViewDelegate {
  func saveDetails(index: Int) {
    myTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
  }
}

// MARK: ColorViewDelegate
extension MainViewController: ColorViewDelegate {
  func changeThemeColor(color: ThemeColor) {
    themeColor = color
    listLabel.textColor = themeColor.color()
    numberOfRemindersLabel.textColor = themeColor.color()
    myTableView.reloadData()
  }
}




