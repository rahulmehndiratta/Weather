//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

struct WeatherModel {
    let city: CityModel
    let dayForecasts: [DayForecastModel]

    init(weather: WeatherResponse) {
        self.city = CityModel(weather: weather)
        self.dayForecasts = weather.forecast?.forecastday.map { forecast in
                    DayForecastModel(date: forecast.date,
                                     icon: forecast.day.condition.icon,
                                     minTemp: "MIN: \(forecast.day.mintempC)°C",
                                     maxTemp: "MAX: \(forecast.day.maxtempC)°C")
                } ?? []
    }
}
