//
//  Reminder.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/12/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation

enum Priority {
  case none, one, two, three
}

class Reminder {
  var title: String
  var willRemindByDate: Bool
  var willRemindAtLocation: Bool
  var repeatedTime: Int
  var isRepeated: Bool?
  var note: String?
  var isCompleted: Bool
  var remindDay: Date?
  var priority: Priority
  
  init(title: String) {
    self.title = title
    self.willRemindByDate = false
    self.willRemindAtLocation = false
    self.repeatedTime = 0
    self.isRepeated = false
    self.note = ""
    self.isCompleted = false
    self.priority = .none
  }
  
}
