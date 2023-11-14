//
//  Utility.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import UIKit

extension UILabel {
    static func createLabel(ofSize: CGFloat = 10, textColor: UIColor = .white) -> Self {
        let label = Self()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: ofSize)
        label.textColor = textColor
        return label
    }
}

struct DateUtils {
    static func formatDate(date: String, inputFormat: String, outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        guard let inputDate = dateFormatter.date(from: date) else { return nil }

        dateFormatter.dateFormat = outputFormat
        let outputDate = dateFormatter.string(from: inputDate)
        return outputDate
    }
}
