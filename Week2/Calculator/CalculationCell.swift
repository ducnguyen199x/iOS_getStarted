//
//  CalculationCell.swift
//  Calculator
//
//  Created by Nguyen Thanh Duc on 10/6/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class CalculationCell: UITableViewCell {
  
  @IBOutlet var calculationLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
