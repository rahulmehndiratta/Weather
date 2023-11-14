//
//  ForecastListViewToPresenterProtocol.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

protocol ForecastListViewToPresenterProtocol: AnyObject {
    func viewDidLoad()
    func searchWeatherForecast(for cityName: String)
}
