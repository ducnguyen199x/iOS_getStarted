//
//  CircleViewModel.swift
//  RxSwiftObservable
//
//  Created by Nguyen Thanh Duc on 11/4/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import ChameleonFramework

class CircleViewModel {
  
  var centerVariable = Variable<CGPoint?>(CGPoint.zero)
  var backgroundColorObservable: Observable<UIColor>!
  
  init() {
    setup()
  }
  
  func setup() {
    backgroundColorObservable = centerVariable.asObservable()
      .map { center in
        guard let center = center else { return UIColor.flatten(UIColor.black)() }
        
        let red: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255.0)) / 255.0
        let green: CGFloat = 0.0
        let blue: CGFloat = 0.0
        
        return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
    }
  }
}

