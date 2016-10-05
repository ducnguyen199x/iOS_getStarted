//
//  ViewController.swift
//  loginForm
//
//  Created by Nguyen Thanh Duc on 10/3/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet var companyLogo: UIImageView!
  @IBOutlet var usernameTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var scrollView: UIScrollView!
  
  //click login button
  @IBAction func loginButtonClicked(_ sender: AnyObject) {
    loginAction(sender)
  }
  
  //AlertController
  let alertController = UIAlertController(title: "Login", message: "No message", preferredStyle: UIAlertControllerStyle.alert)
  let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
  }
  
  var logo = UIImage(named: "2359Media_logo_FA")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    companyLogo.image = logo
    usernameTextField.delegate = self
    keyboardObserver()
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.hideKeyboard))
    view.addGestureRecognizer(tap)
    alertController.addAction(okAction)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField == passwordTextField {
      passwordTextField.text = ""
    }
  }
  
  //tap Return on keyboard
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == passwordTextField {
      loginAction(textField)
    }
    return true
  }
  
  //notify when hide/show keyboard
  func keyboardObserver() {
    NotificationCenter.default.addObserver(self, selector: #selector (ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector (ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  func keyboardWillShow(notification: NSNotification) {
    let userInfo:NSDictionary = notification.userInfo! as NSDictionary
    let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
    let keyboardRectangle = keyboardFrame.cgRectValue
    let keyboardHeight = keyboardRectangle.height
    scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
    
  }
  
  func keyboardWillHide() {
    scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
  }
}

//MARK: Actions
extension ViewController {
  //login action
  func loginAction(_ sender: AnyObject) {
    if usernameTextField.text == "admin" && passwordTextField.text == "admin" {
      alertController.message = "You have successfully logged in"
    }else {
      alertController.message = "Invalid credentials, please try again"
      usernameTextField.text = ""
      passwordTextField.text = ""
    }
    present(alertController, animated: true, completion:  nil)
  }
  
  //dismiss keyboard
  func hideKeyboard() {
    view.endEditing(true)
  }
}
