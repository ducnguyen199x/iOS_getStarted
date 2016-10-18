//
//  ColorViewController.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/18/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

class ColorViewController: UITableViewController {
  
  var colorsArray = [ThemeColor.blue, ThemeColor.red, ThemeColor.green, ThemeColor.yellow, ThemeColor.lightGray]
  var currentColor: ThemeColor = .blue
  var delegate: ColorViewDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return colorsArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as! ColorCell
    
    cell.colorLabel.text = colorsArray[indexPath.row].description()
    cell.colorImage.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    cell.colorImage.layer.cornerRadius = 10
    cell.colorImage.clipsToBounds = true
    cell.colorImage.backgroundColor = colorsArray[indexPath.row].color()
    if colorsArray[indexPath.row] == currentColor {
      cell.accessoryType = .checkmark
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)
    cell?.accessoryType = .checkmark
    delegate?.changeThemeColor(color: colorsArray[indexPath.row])
    _ = navigationController?.popToRootViewController(animated: true)
  }
}
