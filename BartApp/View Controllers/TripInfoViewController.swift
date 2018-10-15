//
//  ArrivalInfoViewController.swift
//  BartApp
//
//  Created by Anthony Chan on 9/18/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import Foundation
import UIKit

class TripInfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tripTableView: UITableView = {
        let tripTableView = UITableView()
        tripTableView.translatesAutoresizingMaskIntoConstraints = false
        tripTableView.register(TripInfoTableViewCell.self, forCellReuseIdentifier: "tripInfoTableViewCell")
        
        return tripTableView
    }()
    
    var tripList = [Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tripTableView.dataSource = self
        tripTableView.delegate = self
        view.addSubview(tripTableView)
        setUpAutoLayout()
        print("TripInfoViewController is loaded.")
        BartAPI.getArrivalInfo(from: "oakl", to: "mlbr") { (tripList) in
            self.tripList = tripList
            self.tripTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripInfoTableViewCell", for: indexPath) as! TripInfoTableViewCell
        
        cell.trip = tripList[indexPath.row]
        
        return cell
    }
    
    func setUpAutoLayout() {
        tripTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tripTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tripTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tripTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tripTableView.rowHeight = UITableViewAutomaticDimension
        tripTableView.estimatedRowHeight = 50
    }
}
