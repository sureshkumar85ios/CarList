//
//  MyDataProvider.swift
//  CarTest_17
//
//  Created by ADDC on 1/14/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import Foundation

class MyDataProvider {
  
  static var instance: MyDataProvider {
    return MyDataProvider()
  }
  
  func requestData(_ offset: Int, size: Int, listener: @escaping ([Car]) -> Void) {
    DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
      // simulate delay
      sleep(2)
      
      NSLog("calling")
      // generate items
      let items = (offset...(offset + size)).map {
        Car(name: "Item \($0)")
      }
      
      // call listener in main thread
      DispatchQueue.main.async {
        listener(items)
      }
    }
  }
}
