//
//  ForecastListInteractor.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation
import Combine

final class ForecastListInteractor {
    weak var presenter: ForecastListInteractorToPresenterProtocol?
    let weatherRemoteAPI: WeatherRemoteAPI
    private var bag = [AnyCancellable]()
    
    init(presenter: ForecastListInteractorToPresenterProtocol? = nil, weatherRemoteAPI: WeatherRemoteAPI) {
        self.presenter = presenter
        self.weatherRemoteAPI = weatherRemoteAPI
    }
}

extension ForecastListInteractor: ForecastListPresenterToInteractorProtocol {
    func getWeatherListForSearch(city: String) {
        weatherRemoteAPI.getWeather(for: city)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    print("Response from getWeather: \(error.localizedDescription)")
                    self.presenter?.manageForecastListErrorResponse(error: error.localizedDescription)
                case .finished:
                    print("finished getWeather")
                }
            } receiveValue: { response in
                self.presenter?.manageForecastListResponse(response: response)
            }
            .store(in: &bag)
    }
}
