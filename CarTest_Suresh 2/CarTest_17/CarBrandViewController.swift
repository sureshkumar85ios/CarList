//
//  CarBrandViewController.swift
//  CarTest_17
//
//  Created by ADDC on 1/15/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import UIKit

class CarBrandViewController: UIViewController,ShowsAlert {

  let appDelegate = UIApplication.shared.delegate as! AppDelegate

  //MARK: - Constants
  
  fileprivate struct localConstants {
    
    static let carCellId = "CarsTableViewCell"
    static let noResultsFoundMsg = NSLocalizedString("search.no.results.found", comment: "")
  }
  
  //get array list from appDeegate array
  
  var cars: [CarViewModel] = [CarViewModel]()

  //MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet var tableViewFooter: MyFooter!
  
  //MARK: - viewModel array
  
  
  fileprivate var items:Array<Any> = []
  public var searchText: String?
  fileprivate var pageSize = 15
  var noResultsFound = false
  var noMatchFound = false
  var carCode:String = ""

  //footer view
  fileprivate var loading = false {
    
    didSet {
      tableViewFooter.isHidden = !loading
    }
    
  }
  
  //MARK: - ScrollView Delwegate Methods
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    // UITableView only moves in one direction, y axis
    
    let currentOffset = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
    
    
    // Change -40 to adjust the distance from bottom
    
    if (maximumOffset - currentOffset) < -40 {
      
      loadSegment(items.count, size: pageSize)
      
      
    }
  }
  
  func loadSegment(_ offset: Int, size: Int) {
    
    if (!loading) {
      loading = true
      
      NetwokDataProvider.instance.requestbrandData(offset, size: size, manufacturer:carCode) {_ in
        self.tableView.reloadData()
        self.loading = false
        self.pageSize += 15 //increase the page count once the webservice cycle has completed

      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    appDelegate.brandlist.removeAll()
    tableViewFooter.isHidden = true
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
//MARK: - UITableViewDataSource Methods

extension CarBrandViewController : UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows

    if noResultsFound || noMatchFound {
      return 1
    }
    return appDelegate.brandlist.count
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    if noResultsFound {
      return NoResultsFoundTableViewCell.cell(message: localConstants.noResultsFoundMsg)
    }
    
    let carCell = tableView.dequeueReusableCell(withIdentifier: localConstants.carCellId) as! carListTableViewCell

    if appDelegate.brandlist.count > 0 {
      
      let carViewModel = appDelegate.brandlist[indexPath.row]
      carCell.setData(data: carViewModel)
      
    }
    return carCell
  }
}

//MARK: - UITableViewDelegate Methods

extension CarBrandViewController : UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.backgroundColor = UIColor .groupTableViewBackground

  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let carViewModel = appDelegate.brandlist[indexPath.row]

    let dis_string = "you have selected "+self.title!+"--"+carViewModel.modelText
    showAlert(message: dis_string)

  }
}
