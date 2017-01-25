//
//  BaseTableViewCell.swift
//  CarTest_17
//
//  Created by ADDC on 1/13/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

  class func identifier() -> String {
    return String(describing: type(of: self))
  }
  
  override func awakeFromNib() {
    self.setupUI()
    super.awakeFromNib()
  }
  
  func setupUI() {
    // Mostly implemented in Child view controller, if common implementation is done then this
    // Super implementation should be called
  }
  
  func setData(data: CarViewModel) {
    // Mostly implemented in Child views
  }

}
