//
//  ViewController.swift
//  WKWebView
//
//  Created by Nguyen Thanh Duc on 10/19/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController {

  @IBOutlet var cancelButton: UIButton!
  @IBOutlet var loadingIndicator: UIActivityIndicatorView!
  @IBOutlet var addressTextField: UITextField!
  @IBOutlet var backButton: UIBarButtonItem!
  @IBOutlet var forwardButton: UIBarButtonItem!
  
  var webView: WKWebView?
  
  @IBOutlet var myView: UIView!
  
  override func loadView() {
    super.loadView()
    self.webView = WKWebView.init(frame: myView.frame)
    self.webView?.navigationDelegate = self
    self.myView.addSubview(self.webView!)
    self.myView.addSubview(loadingIndicator)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    loadingIndicator.isHidden = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //Button Pressed
  @IBAction func goBackButtonPressed(_ sender: AnyObject) {
    _ = self.webView?.goBack()
  }
  
  @IBAction func goForwardButtonPressed(_ sender: AnyObject) {
    _ = self.webView?.goForward()
  }
}

// MARK: Utility
extension ViewController {
  func loadURL(url: String) {
    var url = url
    
    
    //Make Https
    if url.contains("http://") {
      url = "https://" + url.components(separatedBy: "http://")[1]
    }
    
    addressTextField.text = url
    
    if let urlToLoad =  URL(string: url){
      let request = URLRequest(url: urlToLoad)
      _ = self.webView?.load(request)
    } else {
      print("error")
    }
  }
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    //cancelButton.frame.width = 0
    guard let url = addressTextField.text else { return }
  
    loadURL(url: url)
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    
  }
}

// MARK: WKNavigationDelegate
extension ViewController: WKNavigationDelegate {
  func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    loadingIndicator.isHidden = false
    loadingIndicator.startAnimating()
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    loadingIndicator.stopAnimating()
    loadingIndicator.isHidden = true
    backButton.isEnabled = webView.canGoBack
    forwardButton.isEnabled = webView.canGoForward
  }
}

