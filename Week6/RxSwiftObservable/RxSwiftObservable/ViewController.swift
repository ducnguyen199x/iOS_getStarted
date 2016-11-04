//
//  ViewController.swift
//  RxSwiftObservable
//
//  Created by Nguyen Thanh Duc on 11/4/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import UIKit
import ChameleonFramework
import RxCocoa
import RxSwift


class ViewController: UIViewController {

  var circleView: UIView!
  let disposeBag = DisposeBag()
  var circleViewModel: CircleViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func setup() {
    // Add circle view
    circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
    circleView.layer.cornerRadius = circleView.frame.width / 2.0
    circleView.center = view.center
    circleView.backgroundColor = UIColor.green
    view.addSubview(circleView)
    
    circleViewModel = CircleViewModel()
    
    circleView
      .rx.observe(CGPoint.self, "center")
      .bindTo(circleViewModel.centerVariable)
      .addDisposableTo(disposeBag)
    
    circleViewModel.backgroundColorObservable
      .subscribe(onNext: { backgroundColor in
        UIView.animate(withDuration: 0.1) {
          self.circleView.backgroundColor = backgroundColor
          let viewBackgroundColor = UIColor.init(complementaryFlatColorOf: backgroundColor, withAlpha: 1.0)
          if viewBackgroundColor != backgroundColor {
            self.view.backgroundColor = viewBackgroundColor
          }
        }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
      .addDisposableTo(disposeBag)
    
    // Add gesture recognizer
    let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved))
    circleView.addGestureRecognizer(gestureRecognizer)
  }
  
  func circleMoved(recognizer: UIPanGestureRecognizer) {
    let location = recognizer.location(in: view)
    UIView.animate(withDuration: 0.1) { 
      self.circleView.center = location
    }
  }
}

