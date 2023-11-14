//
//  Router.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndPointType
    @discardableResult
    func request<T: Decodable>(_ route: EndPoint, responseHandler: RemoteAPIResponseHandler?, decodingStrategy: JSONDecoder.KeyDecodingStrategy, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask?
    func cancel()
}
