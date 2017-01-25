//
//  MyFooter.swift
//  CarTest_17
//
//  Created by ADDC on 1/14/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import UIKit

class MyFooter: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  
  override func awakeFromNib() {
    self.activityIndicator.startAnimating()
  }

}
