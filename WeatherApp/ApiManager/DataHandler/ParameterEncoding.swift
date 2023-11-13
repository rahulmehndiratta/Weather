//
//  ParameterEncoding.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

typealias Parameters = [String: Any]
protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter encoding fail"
    case missingURL = "URL is nil"
}
