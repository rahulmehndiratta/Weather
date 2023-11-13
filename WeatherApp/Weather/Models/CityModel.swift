//
//  CityModel.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

struct CityModel {
    let name: String
    let country: String
    let dateTime: String

    init(weather: WeatherResponse) {
        self.name = weather.location?.name ?? ""
        self.country = weather.location?.country ?? ""
        self.dateTime = weather.location?.localtime ?? ""
    }

    var displayDateTime: String? {
        DateUtils.formatDate(date: dateTime, inputFormat: "yyyy-MM-dd HH:mm", outputFormat: "dd MMM hh:mm a")
    }
}
