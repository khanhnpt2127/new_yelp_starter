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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        businesses = [Business]()
        self.businessTableView.dataSource = self
        self.businessTableView.delegate = self
        self.businessTableView.estimatedRowHeight = 100
        self.businessTableView.rowHeight = UITableViewAutomaticDimension
        Business.search(with: "Thai") { (businesses: [Business]?, error: Error?) in
            if let businesses = businesses {
                self.businesses = businesses
                    
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            
            self.businessTableView.reloadData()
            
            
            
            
        }
        
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
