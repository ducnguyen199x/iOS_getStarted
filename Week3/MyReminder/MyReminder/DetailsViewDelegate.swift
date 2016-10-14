//
//  DetailsViewDelegate.swift
//  MyReminder
//
//  Created by Nguyen Thanh Duc on 10/14/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation

protocol DetailsViewDelegate {
  func saveDetails(index: Int, title: String, willRemindByDay: Bool, willRemindAtLocation: Bool,
                   repeatedTime: Int, note: String?,
                   remindDay: Date?, priority: Int)
}
