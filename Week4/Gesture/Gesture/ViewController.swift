//
//  ViewController.swift
//  Gesture
//
//  Created by Nguyen Thanh Duc on 10/20/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var drawingView: UIImageView!
  
  var lastPoint = CGPoint.zero
  let lineWidth: CGFloat = 10
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      lastPoint = touch.location(in: drawingView)
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let currentPoint = touch.location(in: drawingView)
      drawLine(fromPoint: lastPoint, toPoint: currentPoint)
      
      lastPoint = currentPoint
    }
  }
  
  // function to draw line
  func drawLine(fromPoint: CGPoint, toPoint: CGPoint) {
    UIGraphicsBeginImageContext(drawingView.frame.size)
    
    let context = UIGraphicsGetCurrentContext()
    
    drawingView.image?.draw(in: CGRect(x: 0, y: 0, width: drawingView.frame.size.width, height: drawingView.frame.size.height))
    
    // draw line
    context?.move(to: fromPoint)
    context?.addLine(to: toPoint)
    
    //set up line properties
    context?.setLineCap(.round)
    context?.setLineWidth(lineWidth)
    context?.setStrokeColor(red: 0, green: 0, blue: 0, alpha: 1)
    context?.strokePath()
    
    drawingView.image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
  }
  
  // clear view
  @IBAction func clearButtonPressed(_ sender: AnyObject) {
    drawingView.image = nil
  }
}

