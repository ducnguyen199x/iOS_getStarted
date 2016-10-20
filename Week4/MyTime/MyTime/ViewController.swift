//
//  ViewController.swift
//  MyTime
//
//  Created by Nguyen Thanh Duc on 10/20/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var timeLabel: UILabel!
  
  let dateFormatter = DateFormatter()
  var timer: Timer?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    dateFormatter.dateStyle = .none
    dateFormatter.timeStyle = .medium
    // setup timer
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // update time
  func updateTime() {
    let date = Date()
    let timeToDisplay = dateFormatter.string(from: date)
    timeLabel.text = timeToDisplay
  }
}

