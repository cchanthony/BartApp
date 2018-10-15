//
//  BartURL.swift
//  BartApp
//
//  Created by Anthony Chan on 8/26/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import Foundation

class BartUrl {
    static let apiKey = "MW9S-E7SL-26DU-VV8V"
    static let allBartStationsURL = "http://api.bart.gov/api/stn.aspx"
    static let estimatedTimeOfDepartureURL = "http://api.bart.gov/api/etd.aspx"
    static let arrivalInfoURL = "http://api.bart.gov/api/sched.aspx"
    static let fareURL = "http://api.bart.gov/api/sched.aspx?cmd=fare&orig={departure}&dest={destination}&key=\(apiKey)"
    static let holidayScheduleURL = "http://api.bart.gov/api/sched.aspx?cmd=holiday&key=\(apiKey)&json=y"
    static let stationScheduleURL = "http://api.bart.gov/api/sched.aspx?cmd=stnsched&orig={departure}&key=\(apiKey)&json=y"
}
