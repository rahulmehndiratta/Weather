//
//  ForecastListDataProvider.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

final class ForecastListDataProvider {
    private var cachedWeatherModel: WeatherModel?
}

extension ForecastListDataProvider: ForecastListDataSource {
    
    var weatherModelFromLocal: WeatherModel? {
        get {
            if let encodedData = UserDefaults.standard.data(forKey: StringConstants.weatherResponse),
               let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: encodedData) {
                return WeatherModel(weather: weatherResponse)
            }
            return cachedWeatherModel
        }
    }
    
    func saveWeatherResponseInLocal(response: WeatherResponse) {
        let encodedData = try? JSONEncoder().encode(response)
        UserDefaults.standard.set(encodedData, forKey: StringConstants.weatherResponse)
        
        // Update the cached weather model
        cachedWeatherModel = WeatherModel(weather: response)
    }
}
