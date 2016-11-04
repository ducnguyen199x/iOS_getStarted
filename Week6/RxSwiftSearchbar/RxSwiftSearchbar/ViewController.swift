//
//  ViewController.swift
//  RxSwiftSearchbar
//
//  Created by Nguyen Thanh Duc on 11/4/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  var shownCities = [String]()
  let allCities = ["NewYork", "London", "Oslo", "Warsaw", "Berlin", "Praga"]
  let disposeBag = DisposeBag()
  
  @IBOutlet var searchBar: UISearchBar!
  @IBOutlet var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchBar
      .rx.text
      .throttle(0.5, scheduler: MainScheduler.instance)
      .filter { ($0?.characters.count)! > 0 }
      .distinctUntilChanged({ (old, new) -> Bool in
        if new == old {
          return true
        } else {
          return false
        }
      })
      .subscribe(onNext: { (query) in
        self.shownCities = self.allCities.filter { $0.hasPrefix(query!) }
        self.tableView.reloadData()

        }, onError: nil, onCompleted: nil, onDisposed: nil)
      .addDisposableTo(disposeBag)
  }



  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shownCities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchCell
    
    cell.titleLabel.text = shownCities[indexPath.row]
    
    return cell
  }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
  
}
