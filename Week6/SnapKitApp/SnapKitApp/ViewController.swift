//
//  ViewController.swift
//  SnapKitApp
//
//  Created by Nguyen Thanh Duc on 11/1/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let box = UIView()
    box.backgroundColor = UIColor.blue
    
    self.view.addSubview(box)
    
    // MARK: Snapkit Constraints
    
    
    box.snp.makeConstraints { (make) in
      // edges
      
      //make.top.bottom.left.right.equalTo(self.view)
      //make.edges.equalTo(self.view).inset(50)
      //make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(20, 20, 20, 20))
      make.top.equalTo(self.view)
      make.centerX.equalTo(self.view)
      
      // size
      
      make.size.equalTo(CGSize(width: 200, height: 100))
    }
    
    
    
    
    // MARK: Original Constraints adding
//    let topConstraint = NSLayoutConstraint(item: box, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
//    self.view.addConstraint(topConstraint)
//    
//    let bottomConstraint = NSLayoutConstraint(item: box, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
//    self.view.addConstraint(bottomConstraint)
//    
//    let rightConstraint = NSLayoutConstraint(item: box, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
//    self.view.addConstraint(rightConstraint)
//    
//    let leftConstraint = NSLayoutConstraint(item: box, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
//    self.view.addConstraint(leftConstraint)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

