//
//  StationInfoViewController.swift
//  BartApp
//
//  Created by Anthony Chan on 9/11/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import Foundation
import UIKit

class StationInfoViewController: SearchHeaderController, UITableViewDataSource, UITableViewDelegate {
    private let trainTableView: UITableView = {
        let trainTableView = UITableView()
        trainTableView.translatesAutoresizingMaskIntoConstraints = false
        trainTableView.register(IncomingTrainTableViewCell.self, forCellReuseIdentifier: "incomingTrainTableViewCell")
        
        return trainTableView
    }()
    
    var station: Station? = nil
    var groupedTrainList = [String: [IncomingTrain]]()
    
    override func viewDidLoad() {
        searchController = UISearchController(searchResultsController: SearchStationViewController())
        view.backgroundColor = UIColor.white
        trainTableView.dataSource = self
        trainTableView.delegate = self
        trainTableView.tableFooterView = UIView()
        view.addSubview(trainTableView)
        setUpNavigation()
        setUpAutoLayout()
        setUpSearchController()
        
        BartAPI.getEstimatedTimeOfDeparture(at: (station?.abbr)!, completionHandler: { (groupedTrainList) in
            self.groupedTrainList = groupedTrainList
            self.trainTableView.reloadData()
        })
    }
    
    func setUpNavigation() {
        self.title = station?.name
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setUpSearchController() {
        searchController.delegate = self
        searchController.searchResultsController?.view.addObserver(self, forKeyPath: "hidden", options: [], context: nil)
        searchController.searchResultsUpdater = searchController.searchResultsController as? UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Destination"
        definesPresentationContext = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedTrainList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomingTrainTableViewCell", for: indexPath) as! IncomingTrainTableViewCell
        
        let destination = Array(groupedTrainList.keys)[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.destinationNameLabel.text = destination
        cell.estimatedTimeLabel.text = getEstimatedTimes(destination: destination)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func setUpAutoLayout() {
        trainTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        trainTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        trainTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        trainTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    func getEstimatedTimes(destination: String) -> String {
        var estimatedTimes : String = ""
        if let incomingTrains = groupedTrainList[destination] {
            for train in incomingTrains {
                estimatedTimes.append(" " + train.minutes + ", ")
            }
            estimatedTimes.removeLast(2)
            estimatedTimes.append(" mins")
        } else {
            estimatedTimes = "Not Available"
        }
        
        
        return estimatedTimes
    }
}

