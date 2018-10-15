//
//  ViewController.swift
//  BartApp
//
//  Created by Anthony Chan on 8/25/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import UIKit
import ChameleonFramework

class SearchStationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let stationsTableView: UITableView = {
        let stationsTableView = UITableView()
        stationsTableView.translatesAutoresizingMaskIntoConstraints = false
        stationsTableView.register(SearchRouteTableViewCell.self, forCellReuseIdentifier: "searchRouteTableViewCell")

        return stationsTableView
    }()
    
    private var stations = [Station]()
    private var filteredStations = [Station]()
    private var isFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stationsTableView.dataSource = self
        stationsTableView.delegate = self
        
        view.backgroundColor = UIColor.white
        view.addSubview(stationsTableView)
        
        setUpAutoLayout()
        
        BartAPI.getAllBartStations { (nameList) in
            self.stations = nameList
            self.stationsTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredStations.count
        }
        return stations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchRouteTableViewCell", for: indexPath) as! SearchRouteTableViewCell
        let station :  Station
        if isFiltering {
            station = filteredStations[indexPath.row]
        } else {
            station = stations[indexPath.row]
        }
        cell.station = station
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SearchRouteTableViewCell
        if self.presentingViewController is HomeViewController {
            let stationInfoViewController = StationInfoViewController()
            stationInfoViewController.station = cell.station
            self.presentingViewController?.navigationController?.pushViewController(stationInfoViewController, animated: true)
        } else if self.presentingViewController is StationInfoViewController {
            self.presentingViewController?.navigationController?.pushViewController(TripInfoViewController(), animated: true)
        }
    }

    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredStations = stations.filter({(station : Station) -> Bool in
            return station.name.lowercased().contains(searchText.lowercased())
        })
        
        stationsTableView.reloadData()
    }
    
    func setUpAutoLayout() {
        stationsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stationsTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        stationsTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        stationsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension SearchStationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print("updating")
        isFiltering = searchController.isActive && !(searchController.searchBar.text?.isEmpty)!
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

