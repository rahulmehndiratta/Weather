//
//  ForecastConfigurator.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation
import UIKit

final class ForecastListModule {
    
    func build() -> UIViewController {
        let viewController = ForecastListVC()
        
        let interactor = ForecastListInteractor(weatherRemoteAPI: WeatherFetcher())

        let router = ForecastListRouter()
        let dataProvider = ForecastListDataProvider()
        let presenter = ForecastListPresenter(view: viewController,
                                          interactor: interactor,
                                          router: router,
                                          dataProvider: dataProvider)
        
        interactor.presenter = presenter
        viewController.presenter = presenter
        viewController.dataSource = dataProvider
        return viewController
    }
}
