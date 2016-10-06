//
//  HistoryTableView.swift
//  Calculator
//
//  Created by Nguyen Thanh Duc on 10/6/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  var calculationsArray = [String]()
  var delegate: HistoryViewDelegate?
  let alertController = UIAlertController(title: "Clear History", message: "Delete All?", preferredStyle: UIAlertControllerStyle.alert)
  
  
  @IBOutlet var tableView: UITableView!
  
  @IBAction func dismissView(_ sender: AnyObject) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func clearButtonClicked(_ sender: AnyObject) {
    present(alertController, animated: true, completion: nil)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default) {
      (action) in self.clearHistory()
    })
    alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel))
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return calculationsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "calculationCell", for: indexPath) as! CalculationCell
    cell.calculationLabel.text = calculationsArray[indexPath.row]
    return cell
  }
  
  func clearHistory() {
    calculationsArray.removeAll()
    delegate?.didClearHistory(calculationsArray)
    tableView.reloadData()
  }

}
