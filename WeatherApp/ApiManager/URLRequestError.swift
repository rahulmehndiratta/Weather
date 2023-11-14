//
//  URLRequestError.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

enum URLRequestError: Error {
    case badRequest
    case internalServerError
    case outdated
    case unknown
    case unauthorized
    case unexpectedStatusCode
}
