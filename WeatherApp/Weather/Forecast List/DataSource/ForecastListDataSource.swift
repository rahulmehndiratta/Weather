//
//  ForecastListDataSource.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

protocol ForecastListDataSource: AnyObject {
    var weatherModelFromLocal: WeatherModel? { get }
    
    func saveWeatherResponseInLocal(response: WeatherResponse)
}
