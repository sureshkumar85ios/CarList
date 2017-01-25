//
//  ViewController.swift
//  CarTest_17
//
//  Created by ADDC on 1/13/17.
//  Copyright © 2017 sureshkumar. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
  
  
  let appDelegate = UIApplication.shared.delegate as! AppDelegate

  //MARK: - Constants for uitableviewcell identifier

  fileprivate struct localConstants {
    
    static let carCellId = "CarsTableViewCell"
    static let noResultsFoundMsg = NSLocalizedString("search.no.results.found", comment: "")
  }
  
  //get array list from appDeegate array
  
  var cars: [CarViewModel] = (UIApplication.shared.delegate as! AppDelegate).carslist


  //MARK: - IBOutlets
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet var tableViewFooter: MyFooter!

  //MARK: - viewModel array

  fileprivate var items:Array<Any> = []
  public var searchText: String?
  public var pageSize:Int = 15
  var noResultsFound = false
  var noMatchFound = false
  var carCodeToPass:String!
  var carNameToPass:String!



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
  
  
  //loading values pagination
  func loadSegment(_ offset: Int, size: Int) {
    
    if (!loading) {
      
        loading = true
        NetwokDataProvider.instance.requestData(offset, size: size) {_ in
        self.tableView.reloadData()
        self.loading = false
        self.pageSize += 15 //increase the page count once the webservice cycle has completed
      
      }
    }


  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Car List"
    tableViewFooter.isHidden = true
    loadSegment(0, size: pageSize)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "Detail") {
      // initialize new view controller and cast it as your view controller
      let view = segue.destination as! CarBrandViewController
      // your new view controller should have property that will store passed value
      view.carCode = carCodeToPass
      view.title = carNameToPass
      
    }
  }

}
//MARK: - UITableViewDataSource Methods

extension ViewController : UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if noResultsFound || noMatchFound {
      return 1
    }
    
    return self.appDelegate.carslist.count

  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    if noResultsFound {
      return NoResultsFoundTableViewCell.cell(message: localConstants.noResultsFoundMsg)
    }

    
    let carCell = tableView.dequeueReusableCell(withIdentifier: localConstants.carCellId) as! carListTableViewCell

    if self.appDelegate.carslist.count > 0 {

      let carViewModel = self.appDelegate.carslist[indexPath.row]
      carCell.setData(data: carViewModel)

    }
    
    return carCell
  }
}

//MARK: - UITableViewDelegate Methods

extension ViewController : UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    if (indexPath.row % 2) != 0{
      cell.backgroundColor = UIColor .lightText
    }else{
      cell.backgroundColor = UIColor .groupTableViewBackground
      
    }
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let carViewModel = self.appDelegate.carslist[indexPath.row]
    carCodeToPass = carViewModel.makeText
    carNameToPass = carViewModel.modelText
    performSegue(withIdentifier: "Detail", sender: self)
  }

}





