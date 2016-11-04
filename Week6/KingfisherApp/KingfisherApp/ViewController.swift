//
//  ViewController.swift
//  KingfisherApp
//
//  Created by Nguyen Thanh Duc on 11/2/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Kingfisher
import FLEX

class ViewController: UIViewController {

  @IBOutlet var imageView: UIImageView!
  @IBOutlet var imageView2: UIImageView!
  @IBOutlet var progressView: UIProgressView!
  @IBOutlet var progressView2: UIProgressView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Clear cache
    KingfisherManager.shared.cache.clearDiskCache()
    KingfisherManager.shared.cache.clearMemoryCache()
    
    // Load image with Kingfisher
    let url = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Swift_logo.svg/2000px-Swift_logo.svg.png")
    imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: {
      (received, total) in
      
      let percentage = Float(received) / Float(total) * 100
      self.progressView.progress = percentage
      
    })
    
    let url2 = URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Swift_logo.svg/2000px-Swift_logo.svg.png")
    imageView2.kf.setImage(with: url2, placeholder: nil, options: nil, progressBlock: {
      (received, total) in
      
      let percentage = Float(received) / Float(total) * 100
      self.progressView2.progress = percentage
    })
    
    #if DEBUG
      FLEXManager.shared().showExplorer()
    #endif
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()

    
  }

}

