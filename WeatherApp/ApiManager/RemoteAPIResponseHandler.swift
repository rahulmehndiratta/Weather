//
//  RemoteAPIResponseHandler.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

protocol RemoteAPIResponseHandler {
    func handleNetworkResponse(_ response: URLResponse?, data: Data?) -> Result<Void, Error>
}
