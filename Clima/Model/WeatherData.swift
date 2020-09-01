//
//  WeatherData.swift
//  Clima
//
//  Created by Maria Yelfimova on 8/29/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

//a struct that receives data from json
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
