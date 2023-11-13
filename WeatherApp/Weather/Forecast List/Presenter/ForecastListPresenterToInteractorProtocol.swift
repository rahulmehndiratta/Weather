//
//  ForecastListPresenterToInteractorProtocol.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

protocol ForecastListPresenterToInteractorProtocol: AnyObject {
    func getWeatherListForSearch(city: String)
}
