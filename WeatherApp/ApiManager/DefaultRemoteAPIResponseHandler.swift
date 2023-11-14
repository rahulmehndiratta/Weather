//
//  DefaultRemoteAPIResponseHandler.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

class DefaultRemoteAPIResponseHandler: RemoteAPIResponseHandler {
    func handleNetworkResponse(_ response: URLResponse?, data: Data?) -> Result<Void, Error> {
        guard let response = response as? HTTPURLResponse else { return .failure(URLRequestError.unknown) }
        NetworkLogger.log(response: response)
        switch response.statusCode {
        case 200...299: return .success(())
        case 400...403: return .success(())
        case 404...499: return .failure(URLRequestError.unauthorized)
        case 501...599: return .failure(URLRequestError.internalServerError)
        case 600: return .failure(URLRequestError.outdated)
        default: return .failure(URLRequestError.unexpectedStatusCode)
        }
    }
}

struct NetworkLogger {
    static func log(request: URLRequest) {
        var data: String {
            if let data =  request.httpBody {
                return String(data: data, encoding: .utf8) ?? ""
            } else {
                return "--"
            }
        }
        let logString = "\(request.url?.absoluteString ?? "--")\nheaders:\(request.allHTTPHeaderFields ?? [:])\ndata:\(data)"
        print("[NETWORK] \(logString)")
    }
    
    static func log(response: HTTPURLResponse) {
        print("Response STATUS CODE: --> \(response.statusCode)")
    }
    
    static func log(responseData data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                print(json)
            }
        } catch {
            print("RESPONSE DATA CANNOT BE CONVERTED TO  a JSON")
        }
    }
}
