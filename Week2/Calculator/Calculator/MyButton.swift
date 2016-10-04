//
//  MyButton.swift
//  Calculator
//
//  Created by Nguyen Thanh Duc on 10/4/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

class MyButton : UIButton {
  @IBInspectable var borderWidth : CGFloat = 0 {
    didSet {
      layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable var borderColor : UIColor? {
    didSet {
      layer.borderColor = borderColor?.cgColor
    }
  }
}
