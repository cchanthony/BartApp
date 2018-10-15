//
//  SearchRouteTableViewCell.swift
//  BartApp
//
//  Created by Anthony Chan on 8/26/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import Foundation
import UIKit

class SearchRouteTableViewCell: UITableViewCell {
    let stationNameLabel : UILabel = {
        let stationNameLabel = UILabel()
//        stationNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        stationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return stationNameLabel
    }()
    
    let timeLabel : UILabel = {
        let timeLabel = UILabel()
//        timeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(stationNameLabel)
        self.contentView.addSubview(timeLabel)
        setUpAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var station: Station? {
        didSet{
            guard let stationItem = station else {return}
            stationNameLabel.text = stationItem.name
            timeLabel.text = stationItem.zipcode
        }
    }
    
    func setUpAutoLayout() {
        stationNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        stationNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        stationNameLabel.trailingAnchor.constraint(equalTo: self.timeLabel.leadingAnchor).isActive = true
        stationNameLabel.heightAnchor.constraint(equalToConstant:40).isActive = true
        
        timeLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -70).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant:40).isActive = true
    }
}
