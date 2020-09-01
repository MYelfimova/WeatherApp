//
//  WeatherManager.swift
//  Clima
//
//  Created by Maria Yelfimova on 8/28/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ weatherManager: WeatherManager, error: Error?)
}

// a struct that send APIrequest and sends back weather data
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4f0a6bfdd1d8f21e1e16e91752730ae0&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName.replacingOccurrences(of: " ", with: "%20"))"
        performRequest(with: urlString)
    }
    func fetchWeather(lat: Double, lon: Double){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create URL
        if let url = URL(string: urlString) {
            
            // 2. Create a URL session
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(self, error: error)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = decodedData.name
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            
            let weather = WeatherModel(cityName: name, conditionId: id, temperature: temp)
            return weather
            //print(weather.conditionName)
            //print(weather.temperatureString)
        } catch {
            self.delegate?.didFailWithError(self, error: error)
        }
        return nil
    }
}



