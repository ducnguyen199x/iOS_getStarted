//
//  Note.swift
//  MyNote
//
//  Created by Nguyen Thanh Duc on 10/11/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation

class Note: NSObject, NSCoding {
  var title: String
  var content: String?
  var dateModified: String
  
  //initializer
  init(title: String, content: String?, dateModified: String) {
    self.title = title
    self.content = content
    self.dateModified = dateModified
  }
  
  required convenience init(coder decoder: NSCoder) {
    let title = decoder.decodeObject(forKey: "title") as! String
    let content = decoder.decodeObject(forKey: "content") as? String
    let dateModified = decoder.decodeObject(forKey: "dateModified") as! String
    
    self.init(title: title, content: content, dateModified: dateModified)
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.title, forKey: "title")
    aCoder.encode(self.content, forKey: "content")
    aCoder.encode(self.dateModified, forKey: "dateModified")
  }
}
