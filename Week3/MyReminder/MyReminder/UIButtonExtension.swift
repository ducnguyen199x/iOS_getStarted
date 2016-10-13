//
//  UIButtonExtension.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/12/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RadioButton: UIButton {
  var color: UIColor?
  var normalColor: UIColor?
  func setBackgroundColor(color: UIColor, forState: UIControlState) {
    self.color = color
    self.normalColor = self.backgroundColor
  }
  
  override var isSelected: Bool {
    didSet {
      self.backgroundColor = isSelected ? color : normalColor
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  @IBInspectable var borderColor: UIColor? {
    didSet {
      layer.borderColor = borderColor?.cgColor
    }
  }
}
