//
//  Reminder.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/12/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation

class Reminder {
  var title: String
  var willRemindByDay: Bool
  var willRemindAtLocation: Bool
  var repeatedTime: Int
  var note: String?
  var isCompleted: Bool
  var remindDay: Date?
  var priority: Int
  
  init(title: String) {
    self.title = title
    self.willRemindByDay = false
    self.willRemindAtLocation = false
    self.repeatedTime = 0
    self.note = ""
    self.isCompleted = false
    self.priority = 0
    self.remindDay = Date()
  }
  
  func save(title: String, willRemindByDay: Bool, willRemindAtLocation: Bool, repeatedTime: Int,
            note: String?, remindDay: Date?, priority: Int) {
    self.title = title
    self.willRemindByDay = willRemindByDay
    self.willRemindAtLocation = willRemindAtLocation
    self.repeatedTime = repeatedTime
    self.note = note
    self.remindDay = remindDay
    self.priority = priority
  }
}
