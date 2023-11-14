//
//  APIRouter.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import Foundation

enum NetworkingError: Error {
    case noData
}

/**
 Network API router.
 - Builds requests
 - Sends request
 - Retrieves the response from the remote server.
 */
class APIRouter<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    private let session: URLSession  = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 30
        config.timeoutIntervalForRequest = 30
        let session = URLSession(configuration: config)
        return session
    }()
    /**
     Performs the request and retrieves the response data from the remote server
     - Parameters:
     - route: info for building the URLRequest
     - responseHandler: an object which validates the response.
     - completion: Completion handler
     - Returns: fired URLSession task
     */
    @discardableResult
    func request<T: Decodable>(_ route: EndPoint, responseHandler: RemoteAPIResponseHandler?, decodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask? {
        do {
            let request = try self.buildRequest(from: route)
            NetworkLogger.log(request: request)
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                var handlerResult: Result<Void, Error> = .success(())
                if let handler = responseHandler {
                    handlerResult = handler.handleNetworkResponse(response, data: data)
                }
                switch handlerResult {
                case .success:
                    do {
                        guard let data = data else {
                            completion(.failure(NetworkingError.noData))
                            return
                        }
                        NetworkLogger.log(responseData: data)
                        let model = try data.decodeTo(type: T.self, strategy: decodingStrategy)
                        completion(.success(model))
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            })
            self.task = task
        } catch {
            completion(.failure(error))
        }
        self.task?.resume()
        return self.task
    }
    /**
     Builds the URLrequest
     - Parameter route: endpoint which holds all the info for building request
     - Throws: encoding error
     - Returns: ready to send URLRequest
     */
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path), cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        request.httpMethod = route.httpMethod.rawValue
        request.allHTTPHeaderFields = route.headers
        do {
            switch route.task {
            case .request:
                request.setValue(NetworkHeaders.applicationJson, forHTTPHeaderField: NetworkHeaders.contentType)
            case .requestParameters(let bodyParameters, let urlParameters):
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)

            case .requestParametersAndHeaders(let bodyParameters,
                                              let urlParameters,
                                              let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    /**
     Configures the URLRequest with parameters
     - Parameters:
     - bodyParameters: represents JSON's body params
     - urlParameters: represents URL Query params
     - request: urlRequest to configure
     - Throws: encoding error
     */
    fileprivate func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }

    /**
     Adds additional headers to the request if needed
     - Parameters:
     - additionalHeaders: HTTPHeaders  to add
     - request: urlRequest which needs additional headers
     */
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

    /// Cancels the URLSessionTask
    func cancel() {
        self.task?.cancel()
    }
}
