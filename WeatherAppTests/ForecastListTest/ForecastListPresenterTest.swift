//
//  ForecastListPresenterTest.swift
//  WeatherAppTests
//
//  Created by Rahul on 13/11/23.
//

@testable import WeatherApp
import XCTest

final class ForecastListPresenterTest: XCTestCase {
    
    var dataSource: ForecastListDataSource?
    var interactor: ForecastListInteractor?
    var presenter: ForecastListPresenter?
    var view: ForecastListViewSpy?
    let weatherFetcher = WeatherFetcherSpy()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        /// View
        view = ForecastListViewSpy()
        
        /// Data Source
        dataSource = ForecastListDataProvider()
        
        /// Interactor
        interactor = ForecastListInteractor(weatherRemoteAPI: weatherFetcher )
        
        /// Router
        let router = ForecastListRouter()
        
        /// presenter
        presenter = ForecastListPresenter(view: view!,
                                      interactor: interactor!,
                                      router: router,
                                      dataProvider: dataSource! as! ForecastListDataProvider)
        
        interactor?.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        dataSource = nil
        interactor = nil
        presenter = nil
        view = nil
    }
    
    func testPresenter() {
        presenter?.viewDidLoad()
        presenter?.searchWeatherForecast(for: "Chandigarh")
        presenter?.manageForecastListResponse(response: weatherFetcher.getMockData())
        presenter?.manageForecastListResponse(response: weatherFetcher.getMockErrorData())
        presenter?.manageForecastListResponse(response: nil)
        presenter?.manageForecastListErrorResponse(error: "No matching location found.")
    }
}

