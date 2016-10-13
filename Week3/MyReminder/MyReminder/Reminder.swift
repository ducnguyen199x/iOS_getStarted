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
  var willRemind: Bool
  var alarm: String?
  var isRepeated: Bool?
  var note: String?
  var isCompleted: Bool
  var remindDay: Date?
  var priority: Priority
  
  init(title: String, willRemind: Bool, alarm: String?, isRepeated: Bool?, note: String?) {
    self.title = title
    self.willRemind = willRemind
    self.alarm = alarm
    self.isRepeated = isRepeated
    self.note = note
    self.isCompleted = false
    self.priority = .none
  }
  
}
