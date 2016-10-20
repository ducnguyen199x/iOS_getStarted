//
//  ViewController.swift
//  MyMapKit
//
//  Created by Nguyen Thanh Duc on 10/20/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

  @IBOutlet var mapView: MKMapView!
  @IBOutlet var mapTypeSegment: UISegmentedControl!
  @IBOutlet var searchTextField: UITextField!
  
  let locationManager = CLLocationManager()
  let geocoder = CLGeocoder()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // change map type
  @IBAction func mapTypeSegmentValueChange(_ sender: AnyObject) {
    switch mapTypeSegment.selectedSegmentIndex {
    case 0:
      mapView.mapType = .standard
    case 1:
      mapView.mapType = .satellite
    case 2:
      mapView.mapType = .hybrid
    default:
      break
    }
  }

}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    guard let address = searchTextField.text else { return }
    
    //geocoding using address in text field
    geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) -> Void in
      guard let placemarks = placemarks else { return }
      
      for placemark in placemarks {
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: (placemark.location?.coordinate)!, span: span)
        self.mapView.setRegion(region, animated: true)
      }
    })
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    searchTextField.endEditing(true)
    return true
  }
}

