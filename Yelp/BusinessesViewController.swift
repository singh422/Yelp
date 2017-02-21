//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,UISearchResultsUpdating{
    
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    var filteredBusinesses: [Business]!
    
    let searchController = UISearchController(searchResultsController: nil)
    var names = [String]()
    var namesList = [String]()
    var positionToInsertAt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        
        self.tableView.tableHeaderView=searchController.searchBar
        searchController.searchBar.delegate = self
        //let searchBar = UISearchBar()
        //searchBar.sizeToFit()
        //navigationItem.titleView = searchBar
        //searchDisplayController!.displaysSearchBarInNavigationBar = true
        //searchController.searchBar.sizeToFit()
        //navigationItem.titleView = searchController.searchBar
    
        
 
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    self.names.insert(business.name!, at: self.positionToInsertAt)
                    self.positionToInsertAt = self.positionToInsertAt + 1
                    print(business.address!)
                }
            }
            
            }
            
        )
        
        
        
        namesList = names
        
        //definesPresentationContext = true
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if searchController.isActive && searchController.searchBar.text != nil
        {
            if filteredBusinesses != nil{
                return filteredBusinesses.count
            }
            else{
                return 0
            }
        }
        
        else{
        
        if businesses != nil{
            return businesses!.count
        }
        else{
            return 0
        }
      
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        if searchController.isActive && searchController.searchBar.text != nil
        {
           cell.business=filteredBusinesses[indexPath.row]
        }
        else
        {
        
        cell.business=businesses[indexPath.row]
        }
        return cell
        
        
    }
    
   /* func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        namesList = searchText.isEmpty ? names : names.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
    
        tableView.reloadData()
    }
    */
    
    func filterContentForSearch(searchString : String)
    {
        self.filteredBusinesses = self.businesses.filter({ (mod) -> Bool in
            return mod.name!.contains(searchString)
            })
        
        
        
        
        
    }
    
    

  func updateSearchResults(for searchController: UISearchController) {
    
    self.filterContentForSearch(searchString: searchController.searchBar.text!)
    self.tableView.reloadData()
    
    /*if let searchText = searchController.searchBar.text {
            namesList = searchText.isEmpty ? names : names.filter({(dataString: String) -> Bool in
                return item.range(searchText, options: .CaseInsensitiveSearch) != nil
            })
            
            tableView.reloadData()
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
