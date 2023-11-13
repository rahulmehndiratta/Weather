//
//  Constant.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

//MARK: NetworkAPI Constants
enum APIConstants {
    static let weatherAPIBaseURL = "https://api.weatherapi.com/v1/"
    static let weatherAPIKey = "522db6a157a748e2996212343221502"
}

enum StringConstants {
    static let network = NSLocalizedString("No response from the server. Please try again", comment: "")
    static let OK = NSLocalizedString("OK", comment: "")
    static let weatherResponse = "weatherResponse"
}
