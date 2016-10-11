//
//  Border.swift
//  MyNote
//
//  Created by Nguyen Thanh Duc on 10/10/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class TextViewBorder : UITextView {
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
