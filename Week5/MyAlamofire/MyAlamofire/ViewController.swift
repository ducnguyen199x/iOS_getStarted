//
//  ViewController.swift
//  MyAlamofire
//
//  Created by Nguyen Thanh Duc on 10/26/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

  @IBOutlet var myTableView: UITableView!
  @IBOutlet var searchBar: UISearchBar!
  
  let searchURL = "https://api.spotify.com/v1/search?q=One%20Direction&type=track"
  var names: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func searchTrack(artistName: String) {
    Alamofire.request("https://api.spotify.com/v1/search", method: .get, parameters: ["q": artistName, "type": "track"]).responseJSON {
      response in
      guard response.result.isSuccess else {
        print("Error while fetching remote rooms: \(response.result.error)")
        return
      }
      
      do {
        guard let readableJSON = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? [String: AnyObject] else {
          print("Malformed data")
          return
        }
        
        guard let tracks = readableJSON["tracks"] as? [String: AnyObject] , let items = tracks["items"] else {
          return
        }
        
        print(items.count)
        
        for i in 0..<items.count {
          let item = items[i] as! [String: AnyObject]
          let itemName = item["name"] as! String
          print(itemName)
          self.names.append(itemName)
          self.myTableView.reloadData()
        }
      } catch {
        print(error)
      }
    }
  }

  // MARK: Keyboard dismissal
  
  func dismissKeyboard() {
    searchBar.resignFirstResponder()
  }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return names.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TrackCell
    
    cell.nameLabel.text = names[indexPath.row]

    return cell
  }
}

// MARK: UISearchBarDelegate
extension ViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    dismissKeyboard()
    names.removeAll()
    if let artistName = searchBar.text {
      searchTrack(artistName: artistName)
    }
  }
}
