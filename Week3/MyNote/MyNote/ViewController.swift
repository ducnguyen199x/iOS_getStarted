//
//  ViewController.swift
//  MyNote
//
//  Created by Nguyen Thanh Duc on 10/10/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NoteDetailViewDelegate {
  var notesList: [(String, String, String)] = [("Assignment 1", "TableView TableView TableView TableView", "10/10/2016")]
  
  @IBOutlet var myTableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let titleImage = UIImage(named: "2359Media_logo_FA")
    let titleImageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 60, height: 35))
    let tempImageView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 35))
    tempImageView.addSubview(titleImageView)
    titleImageView.contentMode = .scaleAspectFit
    titleImageView.image = titleImage
    navigationItem.titleView = tempImageView
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
    
    cell.titleLabel.text = notesList[indexPath.row].0
    cell.dateLabel.text = notesList[indexPath.row].2
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCellEditingStyle.delete {
      notesList.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetails" ,
      let selectedIndex = myTableView.indexPathForSelectedRow?.row,
      let destinationViewController: NoteDetailViewController = segue.destination as? NoteDetailViewController{
      destinationViewController.titleString = notesList[selectedIndex].0
      destinationViewController.content = notesList[selectedIndex].1
      destinationViewController.index = selectedIndex
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

  func saveNote(index: Int, details: (String, String, String)) {
    notesList[index] = details
    myTableView.reloadData()
  }
}



