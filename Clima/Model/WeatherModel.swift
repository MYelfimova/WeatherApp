//
//  WeatherModel.swift
//  Clima
//
//  Created by Maria Yelfimova on 8/29/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let conditionId: Int
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200..<233:
            return "cloud.bolt.rain"
        case 300..<333:
            return "cloud.drizzle.fill"
        case 500..<533:
            return "cloud.heavyrain"
        case 600..<633:
            return "cloud.snow"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 741:
            return "cloud.fog"
        case 701..<790:
            return "smoke"
        case 801..<900:
            return "cloud.fill"
        default:
            return "sun.max"
        }
    }
    
}
