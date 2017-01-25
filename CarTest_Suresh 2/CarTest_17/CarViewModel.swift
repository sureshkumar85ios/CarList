//
//  CarViewModel.swift
//  CarTest_17
//
//  Created by ADDC on 1/14/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import Foundation

class CarViewModel {
  private var car: Car
  
  var modelText: String {
    return car.brand
  }
  
  var makeText: String {
    return car.make
  }
  
  var titleText: String {
    return "\(car.make) \(car.brand)"
  }
  
  init(car: Car) {
    self.car = car
  }
  
  
  
  
}
