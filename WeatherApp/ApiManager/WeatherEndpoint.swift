//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

enum WeatherEndpoint: EndPointType {
    case getWeather(query: String)

    var baseURL: URL { URL(string: APIConstants.weatherAPIBaseURL)! }

    var path: String {
        switch self {
        case .getWeather:
            return "forecast.json"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        }
    }

    var task: HTTPTask {
        switch self {
        case .getWeather(let query):
            let urlParams = [
                "key": APIConstants.weatherAPIKey,
                "q": query,
                "days": "7",
                "aqi": "no",
                "alerts": "no"
            ]
            return .requestParameters(bodyParameters: nil, urlParameters: urlParams)
        }
    }

    var headers: HTTPHeaders? { nil }
}
