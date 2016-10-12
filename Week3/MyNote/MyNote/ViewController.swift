//
//  ViewController.swift
//  MyNote
//
//  Created by Nguyen Thanh Duc on 10/10/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NoteDetailViewDelegate {
  var notesList: [Note] = []
  var indexDelete: IndexPath?
  var dataURL: String = ""

  @IBOutlet var myTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dataURL = getDocumentsDirectory().appendingPathComponent("NotesData").absoluteString
    getFileFromUserDefaults()
    let titleImage = UIImage(named: "2359Media_logo_FA")
    let titleImageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 60, height: 35))
    let tempImageView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
    tempImageView.addSubview(titleImageView)
    titleImageView.contentMode = .scaleAspectFit
    titleImageView.image = titleImage
    navigationItem.titleView = tempImageView
    
    //Save data when App enters background
    NotificationCenter.default.addObserver(self, selector: #selector (ViewController.saveFileToUserDefaults), name: Notification.Name.UIApplicationWillTerminate, object: nil)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return notesList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotesCell
    
    cell.titleLabel.text = notesList[indexPath.row].title
    cell.dateLabel.text = notesList[indexPath.row].dateModified
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCellEditingStyle.delete {
      indexDelete = indexPath
      showDeleteAlert()
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetails" ,
      let destinationViewController: NoteDetailViewController = segue.destination as? NoteDetailViewController {
      if let selectedIndex = myTableView.indexPathForSelectedRow?.row {
        destinationViewController.titleString = notesList[selectedIndex].title
        destinationViewController.content = notesList[selectedIndex].content
        destinationViewController.index = selectedIndex
      }
      destinationViewController.delegate = self
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "showDetails", sender: nil)
    tableView.deselectRow(at: indexPath, animated: true)
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    let detalViewController = storyboard.instantiateViewController(withIdentifier: String(describing: NoteDetailViewController.self))
//    self.navigationController?.pushViewController(detalViewController, animated: true)
  }
  
  //MARK: Save File to System
  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
  }
  func saveFileToUserDefaults() {
    let data = NSKeyedArchiver.archivedData(withRootObject: notesList)
    UserDefaults.standard.set(data, forKey: "notesList")
  }
  
  func getFileFromUserDefaults() {
    if let data = UserDefaults.standard.object(forKey: "notesList") as? Data {
      notesList = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Note]
    }
  }
  
}

//MARK: Utility
extension ViewController {
  func deleteNote (index: IndexPath) {
    notesList.remove(at: index.row)
    myTableView.deleteRows(at: [index], with: UITableViewRowAnimation.automatic)
  }
  
  func showDeleteAlert() {
    let alertDeleteController = UIAlertController.init(title: "Delete Note", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.actionSheet)
    
    alertDeleteController.addAction(UIAlertAction.init(title: "Delete", style: UIAlertActionStyle.destructive, handler: { (action) in
      if let indexDelete = self.indexDelete {
        self.deleteNote(index: indexDelete)
      }
    }))
    alertDeleteController.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel))
    present(alertDeleteController, animated: true, completion: nil)
  }
  
  func showSaveAlert() {
    let alertSaveController = UIAlertController.init(title: "Missing Title", message: "Your note does not have title", preferredStyle: UIAlertControllerStyle.alert)
    alertSaveController.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default))
    present(alertSaveController, animated: true, completion: nil)
  }
  
  //Save note
  func saveNote(index: Int, details: Note) {
    guard details.title != "" else {
      showSaveAlert()
      return
    }
    details.dateModified = getCurrentTime()
    notesList[index] = details
    myTableView.reloadData()
    _ = navigationController?.popToRootViewController(animated: true)
    
  }
  
  //New note
  func createNewNote(details: Note) {
    guard details.title != "" else {
      showSaveAlert()
      return
    }
    details.dateModified = getCurrentTime()
    notesList.append(details)
    myTableView.reloadData()
    _ = navigationController?.popToRootViewController(animated: true)
  }
  
  func getCurrentTime() -> String {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let minutes = calendar.component(.minute, from: date)
    let seconds = calendar.component(.second, from: date)
    let day = calendar.component(.day, from: date)
    let month = calendar.component(.month, from: date)
    let year = calendar.component(.year, from: date)
    
    return "\(year)-\(month)-\(day) \(hour):\(minutes):\(seconds)"
  }
}



