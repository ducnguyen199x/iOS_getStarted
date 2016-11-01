//
//  ViewController.swift
//  CoreDataApp
//
//  Created by Nguyen Thanh Duc on 11/1/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  @IBOutlet var usernameTextField: UITextField!
  @IBOutlet var passwordTextField: UITextField!
  @IBOutlet var statusLabel: UILabel!
  
  var applicationDelegate: AppDelegate?
  var context: NSManagedObjectContext?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    applicationDelegate = UIApplication.shared.delegate as? AppDelegate
    context = applicationDelegate?.persistentContainer.viewContext
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func addButtonPressed(_ sender: AnyObject) {
    guard let context = context else { return }
    guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
    
    let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
    newUser.setValue(username, forKey: "username")
    newUser.setValue(password, forKey: "password")
    
    do {
      try context.save()
    } catch {
      print(error)
    }
  }

  @IBAction func checkButtonPressed(_ sender: AnyObject) {
    guard let context = context else { return }
    guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
    
    let request = NSFetchRequest<Users>(entityName: "Users")
    do {
      let results = try context.fetch(request) as [Users]
      
      let targetUser = results.filter { $0.username == username && $0.password == password }.first
      
      if targetUser != nil {
        statusLabel.text = "Correct"
      } else {
        statusLabel.text = "Incorrect"
      }
    } catch {
      print(error)
    }
  }
  
}

