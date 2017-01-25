//
//  ShowsAlert.swift
//  CarTest_17
//
//  Created by ADDC on 1/16/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import Foundation
import UIKit

protocol ShowsAlert {}//UIAlert

extension ShowsAlert where Self: UIViewController {
  
  func showAlert(title: String = "Alert!", message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alertController, animated: true, completion: nil)
  }
  
}
