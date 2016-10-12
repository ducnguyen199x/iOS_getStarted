//
//  NoteDetailViewController.swift
//  MyNote
//
//  Created by Nguyen Thanh Duc on 10/10/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import UIKit

class NoteDetailViewController: UIViewController {
  
  var titleString: String?
  var content: String?
  var index: Int?
  var delegate: NoteDetailViewDelegate?
  
  @IBOutlet var titleTextField: UITextField!
  @IBOutlet var contentTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleTextField.text = titleString
    contentTextView.text = content
    
  }
  
  @IBAction func saveButton(_ sender: AnyObject) {
    guard let delegate = delegate,
      let title = titleTextField.text
      else { return }
    
    if let index = index,
      let content = contentTextView.text{
      delegate.saveNote(index: index, details: Note(title: title, content: content, dateModified: "11/10/2016"))
    } else {
      delegate.createNewNote(details: Note(title: title, content: content, dateModified: "11/10/2016"))
    }
  }
}
