//
//  NoteDetailViewDelegate.swift
//  MyNote
//
//  Created by Nguyen Thanh Duc on 10/11/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation

protocol NoteDetailViewDelegate {
  func saveNote (index: Int, details: (String, String, String))
}
