//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import UIKit

final class ForecastTVC: UITableViewCell {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .forecastColor
        view.layer.cornerRadius = 3.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let conditionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let minTemperatureLabel: UILabel = {
        UILabel.createLabel(ofSize: 14)
    }()
    
    private let maxTemperatureLabel: UILabel = {
        UILabel.createLabel(ofSize: 14)
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel.createLabel(ofSize: 22)
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(containerView)
        containerView.addSubview(conditionIcon)
        containerView.addSubview(minTemperatureLabel)
        containerView.addSubview(maxTemperatureLabel)
        containerView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            conditionIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            conditionIcon.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            conditionIcon.widthAnchor.constraint(equalToConstant: 64),
            conditionIcon.heightAnchor.constraint(equalToConstant: 64),
            
            minTemperatureLabel.topAnchor.constraint(equalTo: conditionIcon.firstBaselineAnchor),
            minTemperatureLabel.leadingAnchor.constraint(equalTo: conditionIcon.trailingAnchor, constant: 16),
            minTemperatureLabel.widthAnchor.constraint(equalToConstant: 100),
            minTemperatureLabel.heightAnchor.constraint(equalToConstant: 30),
            
            maxTemperatureLabel.bottomAnchor.constraint(equalTo: conditionIcon.lastBaselineAnchor),
            maxTemperatureLabel.leadingAnchor.constraint(equalTo: conditionIcon.trailingAnchor, constant: 16),
            maxTemperatureLabel.widthAnchor.constraint(equalToConstant: 100),
            maxTemperatureLabel.heightAnchor.constraint(equalToConstant: 30),
            
            dateLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with forecast: DayForecastModel?) {
        guard let forecast = forecast else { return }
        conditionIcon.image = UIImage(named: forecast.displayIcon ?? "")
        minTemperatureLabel.text = forecast.minTemp
        maxTemperatureLabel.text = forecast.maxTemp
        dateLabel.text = forecast.displayDate
    }
}

