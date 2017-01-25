//
//  carListTableViewCell.swift
//  CarTest_17
//
//  Created by ADDC on 1/13/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import UIKit

class carListTableViewCell: BaseTableViewCell {
  
//  //MARK: - Constants
//  
  override class func identifier() -> String {
    return "carList"
  }
  
  //MARK: - IBOutlets
  
  @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
   override func setData(data: CarViewModel) {

    self.nameLabel.text = data.modelText
    
  }
}
