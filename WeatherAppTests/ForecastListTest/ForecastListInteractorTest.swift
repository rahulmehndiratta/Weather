//
//  ForecastListInteractorTest.swift
//  WeatherAppTests
//
//  Created by Rahul on 14/11/23.
//

@testable import WeatherApp
import XCTest

final class ForecastListInteractorTest: XCTestCase {
    
    var interactor: ForecastListInteractor?
    let weatherFetcher = WeatherFetcherSpy()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        /// Interactor
        interactor = ForecastListInteractor(weatherRemoteAPI: weatherFetcher)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        interactor = nil
    }
    
    func testinteractor() {
        // call api for error response
        interactor?.getWeatherListForSearch(city: "ch")
        // call api for success response
        interactor?.getWeatherListForSearch(city: "chandigarh")
    }
}
