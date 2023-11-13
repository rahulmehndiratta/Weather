//
//  URLParameterEncoder.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

struct URLParameterEncoder: ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }

        if urlRequest.value(forHTTPHeaderField: NetworkHeaders.contentType) == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: NetworkHeaders.contentType)
        }
    }
}
