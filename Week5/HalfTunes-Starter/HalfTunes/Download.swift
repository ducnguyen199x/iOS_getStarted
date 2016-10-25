//
//  Download.swift
//  HalfTunes
//
//  Created by Nguyen Thanh Duc on 10/24/16.
//  Copyright © 2016 Ken Toh. All rights reserved.
//

import Foundation

class Download: NSObject {
  var url: String
  var isDownloading = false
  var progress: Float = 0.0
  
  var downloadTask: URLSessionDownloadTask?
  var resumeData: Data?
  
  init(url: String) {
    self.url = url
  }
}
