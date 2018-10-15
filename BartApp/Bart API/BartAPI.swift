//
//  BartAPI.swift
//  BartApp
//
//  Created by Anthony Chan on 8/28/18.
//  Copyright © 2018 Anthony Chan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BartAPI {
    static func getAllBartStations(completionHandler: @escaping (_ stationList: [Station]) -> Void) {
        let parameters : Parameters = ["cmd": "stns", "key": BartUrl.apiKey, "json": "y"]
        Alamofire.request(BartUrl.allBartStationsURL, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                let allBartStationsJSON : JSON = JSON(response.result.value!)
//                print(allBartStationsJSON)
                var stationList = [Station]()
                if let stations = allBartStationsJSON["root"]["stations"]["station"].array {
                    for station in stations {
                        let state = station["state"].string!
                        let city = station["city"].string!
                        let name = station["name"].string!
                        let address = station["address"].string!
                        let longitude = station["gtfs_longitude"].string!
                        let latitude = station["gtfs_latitude"].string!
                        let abbr = station["abbr"].string!
                        let county = station["county"].string!
                        let zipcode = station["zipcode"].string!
                        let stationObjcet = Station(state: state,
                                                    city: city,
                                                    name: name,
                                                    address: address,
                                                    longitude: longitude,
                                                    latitude: latitude,
                                                    abbr: abbr,
                                                    county: county,
                                                    zipcode: zipcode)
                        stationList.append(stationObjcet)
                        
                    }
                    completionHandler(stationList)
                } else {
                    print("No stations key in api response")
                }
            } else {
                print("Error \(response.result.error)")
            }
        }
    }
    
    static func getEstimatedTimeOfDeparture(at station: String, completionHandler: @escaping (_ groupedTrainList: [String: [IncomingTrain]]) -> Void) {
        let parameters : Parameters = ["cmd": "etd", "orig": station, "key": BartUrl.apiKey, "json": "y"]
        Alamofire.request(BartUrl.estimatedTimeOfDepartureURL, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                var groupedTrainList = [String: [IncomingTrain]]()
                let incomingTrainsJSON : JSON = JSON(response.result.value!)
//                print(incomingTrainsJSON)
                if let incomingTrains = incomingTrainsJSON["root"]["station"][0]["etd"].array {
                    for incomingTrain in incomingTrains {
                        let destination = incomingTrain["destination"].string!
                        let abbr = incomingTrain["abbreviation"].string!
                        let limited = incomingTrain["limited"].string!
                        if let estimateTimes = incomingTrain["estimate"].array {
                            for estimateTime in estimateTimes {
                                let minutes = estimateTime["minutes"].string!
                                let platform = estimateTime["platform"].string!
                                let direction = estimateTime["direction"].string!
                                let length = estimateTime["length"].string!
                                let hexcolor = estimateTime["hexcolor"].string!
                                let bikeflag = estimateTime["bikeflag"].string!
                                let delay = estimateTime["delay"].string!
                                let train = IncomingTrain(destination: destination, abbr: abbr, limited: limited, minutes: minutes, platform: platform, direction: direction, length: length, hexcolor: hexcolor, bikeflag: bikeflag, delay: delay)
                                if var groupedTrain = groupedTrainList[destination] {
                                    groupedTrain.append(train)
                                    groupedTrainList[destination] = groupedTrain
                                } else {
                                    groupedTrainList[destination] = [train]
                                }
                            }
                        }
                    }
                    completionHandler(groupedTrainList)
                } else {
                    print("No stations key in api response")
                }
            } else {
                print("Error \(response.result.error)")
            }
        }
    }
    
    static func getArrivalInfo(from departureStation: String, to destinationStation: String, completionHandler: @escaping (_ tripList: [Trip]) -> Void) {
        let parameters : Parameters = ["cmd": "depart", "orig": departureStation, "dest": destinationStation, "key": BartUrl.apiKey, "json": "y"]
        Alamofire.request(BartUrl.arrivalInfoURL, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                var tripList = [Trip]()
                let scheduleInfoJSON : JSON = JSON(response.result.value!)
//                print(scheduleInfoJSON)
                let schedule = scheduleInfoJSON["root"]["schedule"]
                let date = schedule["date"].string!
                let time = schedule["time"].string!
                let before = schedule["before"].intValue
                let after = schedule["after"].intValue
                if let trips = schedule["request"]["trip"].array {
                    for i in 0..<after {
                        var fares = [Fare]()
                        var legs = [Leg]()
                        let tripInfo = trips[before + i]
                        let origin = tripInfo["@origin"].string!
                        let destination = tripInfo["@destination"].string!
                        let originTimeMin = tripInfo["@origTimeMin"].string!
                        let originTimeDate = tripInfo["@origTimeDate"].string!
                        let destinationTimeMin = tripInfo["@destTimeMin"].string!
                        let destinationTimeDate = tripInfo["@destTimeDate"].string!
                        let tripTime = tripInfo["@tripTime"].string!
                        if let faresArray = tripInfo["fares"]["fare"].array {
                            for fare in faresArray {
                                let name = fare["@name"].string!
                                let amount = fare["@amount"].string!
                                let fareObject = Fare(name: name, amount: amount)
                                fares.append(fareObject)
                            }
                        }
                        if let legArray = tripInfo["leg"].array {
                            for leg in legArray {
                                let origin = leg["@origin"].string!
                                let destination = leg["@destination"].string!
                                let originTimeMin = leg["@origTimeMin"].string!
                                let originTimeDate = leg["@origTimeDate"].string!
                                let destinationTimeMin = leg["@destTimeMin"].string!
                                let destinationTimeDate = leg["@destTimeDate"].string!
                                let trainHeadStation = leg["@trainHeadStation"].string!
                                let legObject = Leg(origin: origin, destination: destination, originTimeDate: originTimeDate, originTimeMin: originTimeMin, destinationTimeDate: destinationTimeDate, destinationTimeMin: destinationTimeMin, trainHeadStation: trainHeadStation)
                                legs.append(legObject)
                            }
                        }
                        let trip = Trip(date: date, time: time, origin: origin, destination: destination, originTimeMin: originTimeMin, originTimeDate: originTimeDate, destinationTimeMin: destinationTimeMin, destinationTimeDate: destinationTimeDate, tripTime: tripTime, fares: fares, legs: legs)
                        tripList.append(trip)
                    }
                    completionHandler(tripList)
                } else {
                    print("No trip key in api response")
                }
            } else {
                print("Error \(response.result.error)")
            }
        }
    }
}
