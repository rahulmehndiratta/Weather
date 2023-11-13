//
//  ForecastListPresenterToViewProtocol.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

protocol ForecastListPresenterToViewProtocol: AnyObject {
    func configureUiView()
    func refreshList()
    func displayAlert(_ alert: AlertModel)
}
