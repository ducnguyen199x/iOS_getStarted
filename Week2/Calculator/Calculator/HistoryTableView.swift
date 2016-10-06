//
//  HistoryTableView.swift
//  Calculator
//
//  Created by Nguyen Thanh Duc on 10/6/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

class HistoryTableView: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var calculationsArray = [String]()

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return calculationsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "calculationCell", for: indexPath) as! CalculationCell
    cell.calculationLabel.text = calculationsArray[indexPath.row]
    return cell
  }
}
