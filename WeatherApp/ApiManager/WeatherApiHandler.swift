//
//  WeatherApiHandler.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Combine
import UIKit

protocol WeatherRemoteAPI: AnyObject {
    func getWeather(for query: String) -> AnyPublisher<WeatherResponse, Error>
}

final class WeatherFetcher: WeatherRemoteAPI {
    let router: APIRouter<WeatherEndpoint>
    let responseHandler: RemoteAPIResponseHandler

    init() {
        self.router = APIRouter<WeatherEndpoint>()
        self.responseHandler = DefaultRemoteAPIResponseHandler()
    }

    func getWeather(for query: String) -> AnyPublisher<WeatherResponse, Error> {
        requestPublisher(.getWeather(query: query), responseHandler: responseHandler)
    }

    private func requestPublisher<T>(
        _ route: WeatherEndpoint,
        responseHandler: RemoteAPIResponseHandler?,
        decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    ) -> AnyPublisher<T, Error>  where T: Decodable {
        return Deferred {
            Future { promise in
                self.router.request(route, responseHandler: responseHandler, decodingStrategy: decodingStrategy) { (result: Result<T, Error>) in
                    switch result {
                    case .success(let response):
                        promise(.success(response))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }
            }
        }.retry(1)
            .eraseToAnyPublisher()
    }
}

