//
//  ForecastListViewSpy.swift
//  WeatherAppTests
//
//  Created by Rahul on 13/11/23.
//

@testable import WeatherApp
import XCTest

final class ForecastListViewSpy: ForecastListPresenterToViewProtocol {
    func configureUiView() {
        debugPrint("configureUiView")
    }
    
    func refreshList() {
        debugPrint("refreshList")
    }
    
    func displayAlert(_ alert: AlertModel) {
        debugPrint("displayAlert")
    }
}
