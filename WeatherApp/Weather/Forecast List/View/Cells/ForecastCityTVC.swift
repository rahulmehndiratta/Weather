//
//  ForecastCityTVC.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import UIKit

final class ForecastCityTVC: UITableViewCell {
    private let countryLabel: UILabel = {
        UILabel.createLabel(ofSize: 20)
    }()
    
    private let cityLabel: UILabel = {
        return UILabel.createLabel(ofSize: 20)
    }()
    
    private let dateLabel: UILabel = {
        UILabel.createLabel(ofSize: 20)
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(countryLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(dateLabel)

        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            countryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            countryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            cityLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 4),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with city: CityModel?) {
        guard let city = city else { return }
        countryLabel.text = "Country: \(city.country)"
        cityLabel.text = "City: \(city.name)"
        dateLabel.text = "Date: \(city.displayDateTime ?? "")"
    }
}
