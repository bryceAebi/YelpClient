//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import MBProgressHUD


class BusinessViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate, YelpClientDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize searchbar
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.text = "Restaurants"

        
        // setup delegates
        tableView.delegate = self
        tableView.dataSource = self
        YelpClient.sharedInstance.delegate = self
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Business.searchWithTerm(term: "Restaurants", completion: {
            (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        })
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#c41200ff")
    }
    
    func yelpClientDidStartRequest(yelpClient: YelpClient) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func yelpClientDidFinishRequest(yelpClient: YelpClient) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: false)
        searchBar.placeholder = "e.g. tacos, delivery, Max's"
        for ob: UIView in ((searchBar.subviews[0] )).subviews {
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.white, for: .normal)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.placeholder = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil {
            searchBar.resignFirstResponder()
            Business.searchWithTerm(term: searchBar.text!, completion: {
                (businesses: [Business]?, error: Error?) -> Void in
                self.businesses = businesses
                self.tableView.reloadData()
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        let navigationController = segue.destination as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        filtersViewController.delegate = self
     }

    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : Any]) {
        let categories = filters["categories"] as? [String]
        let deals = filters["deals"] as? Bool
        let sort = filters["sort"] as? YelpSortMode
        let radius = filters["radius"] as? Double
        Business.searchWithTerm(term: "Restaurants", sort: sort, categories: categories, deals: deals, radius: radius) {
            (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses ?? []
            self.tableView.reloadData()
        }
    }
}
