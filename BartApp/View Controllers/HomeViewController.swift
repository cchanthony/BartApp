//
//  HomeViewController.swift
//  BartApp
//
//  Created by Anthony Chan on 9/6/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: SearchHeaderController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController = UISearchController(searchResultsController: SearchStationViewController())
        view.backgroundColor = UIColor.blue
        setUpNavigation()
        setUpSearchController()
    }
    
    func setUpNavigation() {
        self.title = "Home"
        navigationItem.searchController = searchController
    }
    
    func setUpSearchController() {
        searchController.delegate = self
        searchController.searchResultsController?.view.addObserver(self, forKeyPath: "hidden", options: [], context: nil)
        searchController.searchResultsUpdater = searchController.searchResultsController as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Departure"
        definesPresentationContext = true
    }
}

