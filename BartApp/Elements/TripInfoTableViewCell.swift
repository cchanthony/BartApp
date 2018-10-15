//
//  TripInfoTableViewCell.swift
//  BartApp
//
//  Created by Anthony Chan on 9/20/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import Foundation
import UIKit

class TripInfoTableViewCell: UITableViewCell {
    let tripNameLabel : UILabel = {
        let tripNameLabel = UILabel()
        tripNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return tripNameLabel
    }()
    
    let totlalTravelTimeLabel : UILabel = {
        let totlalTravelTimeLabel = UILabel()
        totlalTravelTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        return totlalTravelTimeLabel
    }()
    
    let travelTimeDetailLabel : UILabel = {
        let travelTimeDetailLabel = UILabel()
        travelTimeDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        travelTimeDetailLabel.sizeToFit()
        travelTimeDetailLabel.numberOfLines = 0
        travelTimeDetailLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        return travelTimeDetailLabel
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(tripNameLabel)
        self.contentView.addSubview(totlalTravelTimeLabel)
        self.contentView.addSubview(travelTimeDetailLabel)
        setUpAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var trip: Trip? {
        didSet{
            guard let tripItem = trip else {return}
            tripNameLabel.text = tripItem.origin + " to " + tripItem.destination
            totlalTravelTimeLabel.text = tripItem.tripTime + " mins"
            var travelTimeDetail = ""
            for leg in tripItem.legs {
                let destination = leg.destination
                let originTime = leg.originTimeMin
                let trainHeadStation = leg.trainHeadStation
                travelTimeDetail += originTime + " " + trainHeadStation + " train to " + destination + "\n"
            }
            travelTimeDetail.removeLast()
            travelTimeDetailLabel.text = travelTimeDetail
        }
    }
    
    func setUpAutoLayout() {
        tripNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        tripNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        tripNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        totlalTravelTimeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10).isActive = true
        totlalTravelTimeLabel.leadingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -90).isActive = true
        totlalTravelTimeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        
        travelTimeDetailLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        travelTimeDetailLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        travelTimeDetailLabel.topAnchor.constraint(equalTo: self.tripNameLabel.bottomAnchor, constant: 5).isActive = true
        travelTimeDetailLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
    }
}
