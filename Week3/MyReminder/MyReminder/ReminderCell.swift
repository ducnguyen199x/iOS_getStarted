//
//  reminderCell.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/12/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

class ReminderCell: UITableViewCell {
  
  @IBOutlet var titleTextView: UITextView!
  @IBOutlet var completedButton: RadioButton!

  func toLastCellFormat() {
    completedButton.layer.borderWidth = 0
    completedButton.isEnabled = false
    completedButton.setTitle("+", for: .normal)
    titleTextView.text = ""
    titleTextView.isEditable = true
    accessoryType = .none
  }
  
  func toNormalCellFormat() {
    completedButton.setTitle(nil, for: .normal)
    completedButton.isEnabled = true
    titleTextView.isEditable = true
    completedButton.borderWidth = 1.5
    completedButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    completedButton.layer.cornerRadius = 10
    completedButton.clipsToBounds = true
  }
}

