//
//  ForecastListVC.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import UIKit

final class ForecastListVC: UIViewController {
    
    // MARK: Properties
    var presenter: ForecastListViewToPresenterProtocol!
    var dataSource: ForecastListDataSource!
    
    private var tableView: UITableView!
    private var searchTextField: UITextField!
    private var activityIndicator: UIActivityIndicatorView!
    private var emptyStateView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    private func configureUI() {
        searchTextField = UITextField()
        searchTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: searchTextField.frame.height))
        searchTextField.leftViewMode = .always

        searchTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: searchTextField.frame.height))
        searchTextField.rightViewMode = .always

        searchTextField.placeholder = NSLocalizedString("Enter city name", comment: "")
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.delegate = self
        searchTextField.borderStyle = .none
        searchTextField.layer.cornerRadius = 3.0
        searchTextField.backgroundColor = .white
        searchTextField.returnKeyType = .search
        view.addSubview(searchTextField)

        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.color = .red
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.addSubview(activityIndicator)

        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ForecastCityTVC.self, forCellReuseIdentifier: "ForecastCityTVC")
        tableView.register(ForecastTVC.self, forCellReuseIdentifier: "ForecastTVC")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.backgroundColor = .accentColor
    }

    
    private func hideLoader() {
        activityIndicator.isHidden = true
    }
}

extension ForecastListVC: ForecastListPresenterToViewProtocol {
    func configureUiView() {
        configureUI()
        configureEmptyStateView()
    }
    
    func refreshList() {
        hideLoader()
        if let rowCount = dataSource?.weatherModelFromLocal?.dayForecasts.count, rowCount > 0 {
            hideEmptyStateView()
            tableView.reloadData()
        } else {
            showEmptyStateView()
        }
    }
    
    func displayAlert(_ alert: AlertModel) {
        hideLoader()
        let controller = UIAlertController(title: alert.message, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: alert.actionTitle, style: .default, handler:  nil)
        controller.addAction(action)
        self.present(controller, animated: true, completion: nil)
    }
}

extension ForecastListVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else { return true }
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        presenter?.searchWeatherForecast(for: text)
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}

extension ForecastListVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard dataSource != nil else { return 0 }
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataSource?.weatherModelFromLocal?.dayForecasts.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCityTVC", for: indexPath) as! ForecastCityTVC
            cell.configure(with: dataSource?.weatherModelFromLocal?.city)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTVC", for: indexPath) as! ForecastTVC
            let forecast = dataSource?.weatherModelFromLocal?.dayForecasts[indexPath.row]
            cell.configure(with: forecast)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
}

extension ForecastListVC {
    private func configureEmptyStateView() {
        emptyStateView = UIView()
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateView)
        
        let imageView = UIImageView(image: UIImage(named: "empty_state"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        emptyStateView.addSubview(imageView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Please enter a city name and search for the forecast."
        titleLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emptyStateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            imageView.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 150),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            titleLabel.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: emptyStateView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: emptyStateView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16)

        ])
        
        emptyStateView.isHidden = true
    }
    
    private func showEmptyStateView() {
        emptyStateView.isHidden = false
        tableView.isHidden = true
    }
    
    private func hideEmptyStateView() {
        emptyStateView.isHidden = true
        tableView.isHidden = false
    }
}
