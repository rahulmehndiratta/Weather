//
//  DayForecastModel.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

struct DayForecastModel {
    let date: String
    let icon: String
    let minTemp: String
    let maxTemp: String
    
    var displayIcon: String? {
        let url = URL(string: icon)
        let pathComponents = url?.pathComponents
        let lastPart = pathComponents?.suffix(2).joined(separator: "/")
        return lastPart
    }
    
    var displayDate: String? {
        return DateUtils.formatDate(date: date, inputFormat: "yyyy-MM-dd", outputFormat: "dd MMM")
    }
}
