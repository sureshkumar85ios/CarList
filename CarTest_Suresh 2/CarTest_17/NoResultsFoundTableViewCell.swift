//
//  NoResultsFoundTableViewCell.swift
//  CarTest_17
//
//  Created by ADDC on 1/13/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import UIKit

class NoResultsFoundTableViewCell: BaseTableViewCell {
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
  class func cell(message messageToDisplay: String?) -> NoResultsFoundTableViewCell {
    
    let noResultsFoundCell = NoResultsFoundTableViewCell(style: .default, reuseIdentifier: NSStringFromClass(self))
    noResultsFoundCell.textLabel?.text = messageToDisplay
    return noResultsFoundCell
  }
}
