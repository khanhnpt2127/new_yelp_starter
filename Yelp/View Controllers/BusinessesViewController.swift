//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {
    
    @IBOutlet weak var businessTableView: UITableView!
    var businesses: [Business]!
    var searchView: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businesses = [Business]()
        
        
        self.businessTableView.dataSource = self
        self.businessTableView.delegate = self
        self.businessTableView.estimatedRowHeight = 100
        self.businessTableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        
        
        let customBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
        customBarButton.backgroundColor = UIColor.clear
        customBarButton.layer.borderWidth = 1
        customBarButton.layer.cornerRadius = 5
        customBarButton.titleEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4)
        customBarButton.layer.borderColor = UIColor.white.cgColor
//        customBarButton.layer.shadowColor = UIColor.white.cgColor
//        customBarButton.layer.shadowRadius =  12
//        customBarButton.layer.shadowOffset = CGSize(width: 12, height: 12)
        customBarButton.setTitle("Filter", for: UIControlState.normal)
        customBarButton.addTarget(self, action: #selector(self.filterClick(sender:)), for: UIControlEvents.touchUpInside)
        
        
        let barButton = UIBarButtonItem()
        barButton.customView = customBarButton
        self.navigationItem.leftBarButtonItem = barButton
        
        self.searchView = UISearchBar()
        searchView = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        searchView.placeholder = "Search"
        searchView.showsCancelButton = false
        self.navigationItem.titleView = searchView
        searchView.delegate = self
        
        fetchData(searchValue: "")
        
        
        
        
        // Example of Yelp search with more search options specified
        /*
         Business.search(with: "Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]?, error: Error?) in
         if let businesses = businesses {
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         }
         */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //let nextViewController = segue.destination as! FilterViewController
    }
    
    func filterClick(sender: UIButton){
        
        //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "filterController") as! FilterViewController
        
        let navigationController = UINavigationController(rootViewController: nextViewController)
        
        
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
    
    
    func fetchData(searchValue: String){
        
        Business.search(with: searchValue) { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            
            self.businessTableView.reloadData()
            
        }
        
    }
    
}




extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = businessTableView.dequeueReusableCell(withIdentifier: "businessCell") as! BusinessesTableViewCell
        
        cell.businessImageView.setImageWith(businesses[indexPath.row].imageURL!)
        cell.adressLabel.text = businesses[indexPath.row].address
        cell.nameLabel.text = businesses[indexPath.row].name
        cell.ratingImageView.setImageWith(businesses[indexPath.row].ratingImageURL!)
        cell.categoriesLabel.text = businesses[indexPath.row].categories
        cell.distanceLabel.text = businesses[indexPath.row].distance
        cell.reviewedLabel.text = (businesses[indexPath.row].reviewCount?.stringValue)! + " reviewed"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    
    
}


extension BusinessesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.searchView.showsCancelButton = true
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.fetchData(searchValue: self.searchView.text!)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchView.text = ""
        self.fetchData(searchValue: "")
        self.searchView.showsCancelButton = false
        searchView.endEditing(true)
    }
    
}


