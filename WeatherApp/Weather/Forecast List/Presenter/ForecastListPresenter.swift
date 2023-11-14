//
//  ForecastListPresenter.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

final class ForecastListPresenter {
    weak var view: ForecastListPresenterToViewProtocol!
    var interactor: ForecastListPresenterToInteractorProtocol!
    var router: ForecastListPresenterToRouterProtocol!
    var dataSource: ForecastListDataSource!
    
    init(view: ForecastListPresenterToViewProtocol, interactor: ForecastListPresenterToInteractorProtocol, router: ForecastListPresenterToRouterProtocol, dataProvider: ForecastListDataProvider) {
        self.view = view
        self.interactor = interactor
        self.router = router
        dataSource = dataProvider
    }
}

extension ForecastListPresenter: ForecastListViewToPresenterProtocol {
    func viewDidLoad() {
        view.configureUiView()
        view.refreshList()
    }
    
    func searchWeatherForecast(for city: String) {
        interactor.getWeatherListForSearch(city: city)
    }
}

extension ForecastListPresenter: ForecastListInteractorToPresenterProtocol {
    func manageForecastListResponse(response: WeatherResponse?) {
        guard let response = response else {
            let alert = AlertModel(message: StringConstants.network, actionTitle: StringConstants.OK)
            self.view?.displayAlert(alert)
            return
        }
        if let error = response.error {
            let alert = AlertModel(message: error.message, actionTitle: StringConstants.OK)
            self.view?.displayAlert(alert)
        }
        dataSource.saveWeatherResponseInLocal(response: response)
        self.view?.refreshList()
    }
    
    func manageForecastListErrorResponse(error: String) {
        let alert = AlertModel(message: error, actionTitle: StringConstants.OK)
        self.view?.displayAlert(alert)
    }
}
