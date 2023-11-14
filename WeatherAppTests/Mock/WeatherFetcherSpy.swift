//
//  WeatherFetcherSpy.swift
//  WeatherAppTests
//
//  Created by Rahul on 13/11/23.
//

@testable import WeatherApp
import XCTest
import Combine

final class WeatherFetcherSpy: WeatherRemoteAPI {
    func getWeather(for query: String) -> AnyPublisher<WeatherApp.WeatherResponse, Error> {
        if let mockResponse = getMockData(), query.count > 3 {
            return Result.Publisher(Result.success(mockResponse)).eraseToAnyPublisher()
        } else {
            let error = NSError(domain: "Weather", code: 95, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
            let errorResult: Result<WeatherApp.WeatherResponse, Error> = .failure(error)
            return Result.Publisher(errorResult).eraseToAnyPublisher()
        }
    }
    
    func getMockData() -> WeatherResponse? {
        // Load the JSON data from the file
        guard let path = Bundle(for: type(of: self)).path(forResource: "mockResponse", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            XCTFail("Failed to load JSON data from file")
            return nil
        }
        
        // Use JSONDecoder to decode the JSON data into your model
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherResponse.self, from: jsonData)
        } catch {
            XCTFail("Failed to decode JSON into WeatherResponse: \(error)")
            return nil
        }
    }
    
    func getMockErrorData() -> WeatherResponse? {
        // Load the JSON data from the file
        guard let path = Bundle(for: type(of: self)).path(forResource: "MockWeatherErrorResponse", ofType: "json"),
              let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            XCTFail("Failed to load JSON data from file")
            return nil
        }
        
        // Use JSONDecoder to decode the JSON data into your model
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(WeatherResponse.self, from: jsonData)
        } catch {
            XCTFail("Failed to decode JSON into WeatherResponse: \(error)")
            return nil
        }
    }
}
