//
//  NetworkClient.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation
import Combine

protocol NetworkClientProtocol: class {
    typealias Headers = [String: Any]
    
    func request<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
}

final class NetworkClient: NetworkClientProtocol {
    func request<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        // create urlRequest from custom function
        var urlRequest = URLRequest(url: url)
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        // create a Publisher object to go and get the response from the value and publish a value
        // extract data from object
        // decode data to model of choice
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
