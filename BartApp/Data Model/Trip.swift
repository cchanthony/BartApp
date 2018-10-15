//
//  Trip.swift
//  BartApp
//
//  Created by Anthony Chan on 9/19/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import Foundation

struct Trip {
    var date: String
    var time: String
    var origin: String
    var destination: String
    var originTimeMin: String
    var originTimeDate: String
    var destinationTimeMin: String
    var destinationTimeDate: String
    var tripTime: String
    var fares: [Fare]
    var legs: [Leg]
}
