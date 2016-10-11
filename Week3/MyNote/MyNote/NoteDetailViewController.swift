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
  @IBOutlet var contentTextView: TextViewBorder!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    titleTextField.text = titleString
    contentTextView.text = content
    
  }
  
  @IBAction func doneButton(_ sender: AnyObject) {
    dismiss(animated: true, completion: nil)
    if let delegate = delegate,
    let index = index,
    let title = titleTextField.text,
      let content = contentTextView.text {
      delegate.saveNote(index: index, details: (title, content, "11/10/2016"))
    }
  }
}
