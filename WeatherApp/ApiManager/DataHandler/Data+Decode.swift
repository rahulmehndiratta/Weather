//
//  Data+Decode.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

extension Data {
    
    func decodeTo<T: Decodable>(type: T.Type,
                                strategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = strategy
        return try decoder.decode(type, from: self)
    }
}
