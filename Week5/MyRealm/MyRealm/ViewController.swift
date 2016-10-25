//
//  ViewController.swift
//  MyRealm
//
//  Created by Nguyen Thanh Duc on 10/25/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
  
  let realm = try! Realm()
  var pets: [Pet] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let pikachu = Pet()
    pikachu.name = "Tuan"
    pikachu.species = "Pikachu"
    pikachu.age = 5
    
    try! realm.write {
      realm.add(pikachu)
    }
    
    let data = realm.objects(Pet.self)
    pets = Array(data)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pets.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PetCell
    
    cell.nameLabel.text = pets[indexPath.row].name
    cell.speciesLabel.text = pets[indexPath.row].species
    cell.ageLabel.text = "\(pets[indexPath.row].age)"
    
    return cell
  }

}

