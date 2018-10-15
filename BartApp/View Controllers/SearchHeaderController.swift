//
//  SearchViewController.swift
//  BartApp
//
//  Created by Anthony Chan on 9/9/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import Foundation
import UIKit

class SearchHeaderController: UIViewController, UISearchControllerDelegate {
    var searchController : UISearchController!
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchResultsController?.view.isHidden = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let view: UIView = object as! UIView? {
            if (view == searchController.searchResultsController?.view &&
                keyPath == "hidden" &&
                (searchController.searchResultsController?.view.isHidden)! &&
                searchController.searchBar.isFirstResponder) {
                searchController.searchResultsController?.view.isHidden = false
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            searchController.searchResultsController?.view.isHidden = false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchController.searchResultsController?.view.isHidden = true
    }
}
