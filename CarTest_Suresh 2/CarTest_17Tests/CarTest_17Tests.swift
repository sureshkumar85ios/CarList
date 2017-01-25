//
//  CarTest_17Tests.swift
//  CarTest_17Tests
//
//  Created by ADDC on 1/13/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import XCTest
@testable import CarTest_17

extension UIViewController {
  func preloadView() {
    let _ = view
  }
}

class CarTest_17Tests: XCTestCase {
  
  var vc: ViewController!

  
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
      vc.preloadView()
    }
  
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
  
  
  // Test Car ViewModel
  func testCarViewModelWithFerrariF12() {
    let ferrariF12 = Car(brand: "F12", make: "Ferrari")
    let ferrariViewModel = CarViewModel(car: ferrariF12)
    XCTAssertEqual(ferrariViewModel.modelText, "F12")
    XCTAssertEqual(ferrariViewModel.makeText, "Ferrari")
    XCTAssertEqual(ferrariViewModel.titleText, "Ferrari F12")
    
  }
  
  func testCarListTest() {
    
    let url = URL(string: "http://api-aws-eu-qa-1.auto1-test.com/v1/car-types/manufacturer?page=0&pageSize=10&wa_key=coding-puzzle-client-449cc9d")
    
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    let session = URLSession.shared
    
    session.dataTask(with: request) {data, response, err in
      
      if let httpUrlResponse = response as? HTTPURLResponse
      {
        let statusCode: Int? = (response as? HTTPURLResponse)?.statusCode
        XCTAssertEqual(statusCode, 200,"status code was not 200; was /statusCode")
        if (err != nil) {
          print("Error Occurred: \(err?.localizedDescription)")
        } else {
          print("\(httpUrlResponse.allHeaderFields)") // Error
        }
      }
      print("Entered the completionHandler")
      }.resume()

  }
  
  func testBrandListTest() {
    
    let url = URL(string: "http://api-aws-eu-qa-1.auto1-test.com/v1/car-types/main-types?manufacturer=107&page=0&pageSize=10&wa_key=coding-puzzle-client-449cc9d")
    
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    let session = URLSession.shared
    
    session.dataTask(with: request) {data, response, err in
      
      if let httpUrlResponse = response as? HTTPURLResponse
      {
        let statusCode: Int? = (response as? HTTPURLResponse)?.statusCode
        XCTAssertEqual(statusCode, 200,"status code was not 200; was /statusCode")
        if (err != nil) {
          print("Error Occurred: \(err?.localizedDescription)")
        } else {
          print("\(httpUrlResponse.allHeaderFields)") // Error
        }
      }
      print("Entered the completionHandler")
      }.resume()
  }

  
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      
    }
  

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
