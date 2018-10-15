//
//  IncomingTrainTableViewCell.swift
//  BartApp
//
//  Created by Anthony Chan on 9/11/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import Foundation
import UIKit

class IncomingTrainTableViewCell: UITableViewCell {    
    let destinationNameLabel : UILabel = {
        let destinationNameLabel = UILabel()
        //        stationNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        destinationNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return destinationNameLabel
    }()
    
    let estimatedTimeLabel : UILabel = {
        let estimatedTimeLabel = UILabel()
        //        stationNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        estimatedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return estimatedTimeLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(destinationNameLabel)
        self.contentView.addSubview(estimatedTimeLabel)
        setUpAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpAutoLayout() {
        destinationNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        destinationNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        destinationNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        estimatedTimeLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        estimatedTimeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        estimatedTimeLabel.topAnchor.constraint(equalTo: self.destinationNameLabel.bottomAnchor, constant: 10).isActive = true
    }
}
