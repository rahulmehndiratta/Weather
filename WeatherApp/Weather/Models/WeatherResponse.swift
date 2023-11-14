//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

struct WeatherResponse: Codable {
    let error: WeatherError?
    let location: Location?
    let current: Current?
    let forecast: Forecast?
    
    struct Location: Codable {
        let name: String
        let region: String
        let country: String
        let localtimeEpoch: Int
        let localtime: String
    }
    
    struct Current: Codable {
        let tempC: Double
        let tempF: Double
        let isDay: Int
        let condition: Condition
    }
}

struct WeatherError: Codable {
    let code: Int
    let message: String
}

struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
    
    struct ForecastDay: Codable {
        let date: String
        let dateEpoch: Int
        let day: Day
    }
    
    struct Day: Codable {
        let maxtempC: Double
        let mintempC: Double
        let condition: Condition
    }
}
