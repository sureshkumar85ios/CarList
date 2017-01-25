
//  NetworkDataProvider.swift
//  CarTest_17
//
//  Created by ADDC on 1/15/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import Foundation
import UIKit

class NetwokDataProvider {
  

  let appDelegate = UIApplication.shared.delegate as! AppDelegate

  static var instance: NetwokDataProvider {
    
    return NetwokDataProvider()
    
  }
  

  func requestbrandData(_ offset: Int, size: Int,manufacturer: String,listener: @escaping ([CarViewModel]) -> Void) {
    DispatchQueue.global(qos: .background).async {
      // simulate delay
      sleep(2)

        let item = NetWorkParser.getWebserviceResponse("/v1/car-types/main-types?", requestType: "GET", parDic: manufacturer, andPage: Int32(size)) as Dictionary
      
        self.appDelegate.brandlist.removeAll()
      
        for (key, value) in item {
       // print("key is - \(key) and value is - \(value)")
        let item = Car(brand: value as! String, make: key as! String)
        self.appDelegate.brandlist.append(CarViewModel(car: item))
        
          }
      // call listener in main thread
      DispatchQueue.main.async {
        listener(self.appDelegate.brandlist)
      }
    }
  }
  
  func requestData(_ offset: Int, size: Int, listener: @escaping ([CarViewModel]) -> Void) {
    DispatchQueue.global(qos: .background).async {
      // simulate delay
      sleep(2)

        let item = NetWorkParser.getWebserviceResponse("/v1/car-types/manufacturer?", requestType:"GET", parDic:nil, andPage:Int32(size)) as NSDictionary
     
        self.appDelegate.carslist.removeAll()
      
        for (key, value) in item {
       // print("key is - \(key) and value is - \(value)")
        let item = Car(brand: value as! String, make: key as! String)
        self.appDelegate.carslist.append(CarViewModel(car: item))
      }
      // call listener in main thread
      DispatchQueue.main.async {
        listener(self.appDelegate.carslist)
      }
    }
  }
}
