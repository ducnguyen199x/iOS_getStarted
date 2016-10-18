//
//  HeaderViewController.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/18/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

class HeaderViewController: UITableViewHeaderFooterView {
  
  var viewController: MainViewController?
  @IBAction func colorButtonPressed(_ sender: AnyObject) {
    viewController?.performSegue(withIdentifier: "showColorView", sender: viewController)
  }
}
