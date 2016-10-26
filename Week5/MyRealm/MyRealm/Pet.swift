//
//  Pet.swift
//  MyRealm
//
//  Created by Nguyen Thanh Duc on 10/25/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import RealmSwift

class Animal: Object {
  dynamic var name = ""
  dynamic var age = 0
  dynamic var species = ""
  
  override static func primaryKey() -> String? {
    return "name"
  }
}
