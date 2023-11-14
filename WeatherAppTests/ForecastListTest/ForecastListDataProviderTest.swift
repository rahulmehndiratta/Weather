//
//  ForecastListDataSourceTest.swift
//  WeatherAppTests
//
//  Created by Rahul on 14/11/23.
//

@testable import WeatherApp
import XCTest

final class ForecastListDataProviderTest: XCTestCase {
    
    var dataSource: ForecastListDataSource?
    let weatherFetcher = WeatherFetcherSpy()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        dataSource = ForecastListDataProvider()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        dataSource = nil
    }
    
    func testDataSource() {
        if let responseData = weatherFetcher.getMockData() {
            dataSource?.saveWeatherResponseInLocal(response: responseData)
        }
        
        XCTAssertNotNil(dataSource?.weatherModelFromLocal, "Forecast result should not be nil")
    }
}

