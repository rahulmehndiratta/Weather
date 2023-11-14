//
//  JSONParameterEncoder.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: NetworkHeaders.contentType) == nil {
                urlRequest.setValue(NetworkHeaders.applicationJson, forHTTPHeaderField: NetworkHeaders.contentType)
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}
