//
//  ForecastListInteractorToPresenterProtocol.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

protocol ForecastListInteractorToPresenterProtocol: AnyObject {
    func manageForecastListResponse(response: WeatherResponse?)
    func manageForecastListErrorResponse(error: String)
}
