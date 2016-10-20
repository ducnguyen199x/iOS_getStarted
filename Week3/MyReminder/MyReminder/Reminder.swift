//
//  Reminder.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/12/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UserNotifications

class Reminder: NSObject, NSCoding {
  var title: String
  var willRemindByDay: Bool
  var willRemindAtLocation: Bool
  var repeatedTime: Int
  var note: String?
  var isCompleted: Bool
  var remindDay: Date?
  var priority: Int
  var id: UUID
  
  init(title: String) {
    self.title = title
    self.willRemindByDay = false
    self.willRemindAtLocation = false
    self.repeatedTime = 0
    self.note = ""
    self.isCompleted = false
    self.priority = 0
    self.remindDay = Date()
    self.id = UUID.init()
  }
  
  required convenience init(coder decoder: NSCoder) {
    let title = decoder.decodeObject(forKey: "title") as! String
    let willRemindByDay = decoder.decodeBool(forKey: "willRemindByDay")
    let willRemindAtLocation = decoder.decodeBool(forKey: "willRemindAtLocation")
    let repeatedTime = decoder.decodeInteger(forKey: "repeatedTime")
    let note = decoder.decodeObject(forKey: "note") as! String
    let isCompleted = decoder.decodeBool(forKey: "isCompleted")
    let remindDay = decoder.decodeObject(forKey: "remindDay") as! Date
    let priority = decoder.decodeInteger(forKey: "priority")
    
    self.init(title: title)
    save(title: title, willRemindByDay: willRemindByDay, willRemindAtLocation: willRemindAtLocation, repeatedTime: repeatedTime, note: note, remindDay: remindDay, priority: priority)
    self.isCompleted = isCompleted
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.title, forKey: "title")
    aCoder.encode(self.willRemindByDay, forKey: "willRemindByDay")
    aCoder.encode(self.willRemindAtLocation, forKey: "willRemindAtLocation")
    aCoder.encode(self.repeatedTime, forKey: "repeatedTime")
    aCoder.encode(self.note, forKey: "note")
    aCoder.encode(self.isCompleted, forKey: "isCompleted")
    aCoder.encode(self.remindDay, forKey: "remindDay")
    aCoder.encode(self.priority, forKey: "priority")
  }
  
  //save infomation
  func save(title: String, willRemindByDay: Bool, willRemindAtLocation: Bool, repeatedTime: Int,
            note: String?, remindDay: Date?, priority: Int) {
    self.title = title
    self.willRemindByDay = willRemindByDay
    self.willRemindAtLocation = willRemindAtLocation
    self.repeatedTime = repeatedTime
    self.note = note
    self.remindDay = remindDay
    self.priority = priority
    
    cancelNotification()
    
    if willRemindByDay {
      createNotification(date: remindDay, identifier: self.id.description)
    }
  }
  
  func getPriority() -> String {
    return Array<String>(repeating: "!", count: priority).joined()
  }
  
  // Notification
  func createNotification(date: Date?, identifier: String) {
    guard let date = date else { return }
    
    let content = UNMutableNotificationContent()
    content.title = NSString.localizedUserNotificationString(forKey: "Task: \(self.title) is due", arguments: nil)
    content.body = NSString.localizedUserNotificationString(forKey: "Hi, Please check your Reminder, make sure that you do not miss your tasks.", arguments: nil)
    content.sound = UNNotificationSound.default()
    
    // Deliver the notification
    var dateComponent = DateComponents()
    let calendar = Calendar.current
    dateComponent.day = calendar.component(.day, from: date)
    dateComponent.month = calendar.component(.month, from: date)
    dateComponent.year = calendar.component(.year, from: date)
    dateComponent.hour = calendar.component(.hour, from: date)
    dateComponent.minute = calendar.component(.minute, from: date)
    
    let trigger = UNCalendarNotificationTrigger.init(dateMatching: dateComponent, repeats: false)
    let request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
    
    // Schedule the notification.
    let center = UNUserNotificationCenter.current()
    center.add(request)
  }
  
  func cancelNotification() {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.id.description])
  }
  
}
