//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation
import Combine

protocol WeatherRepositoryProtocol: class {
    var networkClient: NetworkClient { get }
    
    func getCurrentWeather(lat: String?, lon: String?, city: String?) -> AnyPublisher<CurrentWeatherResponse, Error>
    func getForecastFive(lat: String?, lon: String?, city: String?) -> AnyPublisher<ForecastResponse, Error>
}

final class WeatherRepository: WeatherRepositoryProtocol {
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCurrentWeather(lat: String? = nil, lon: String? = nil, city: String? = nil) -> AnyPublisher<CurrentWeatherResponse, Error> {
        if city?.isEmpty ?? false || city == nil {
            var endpoint = EndpointPlugin.currentWeather
            let queryItems = [
                URLQueryItem(name: "lat", value: lat),
                URLQueryItem(name: "lon", value: lon),
                URLQueryItem(name: "appid", value: "b0592d72052843dffd9aab55423a04a0")
            ]
            endpoint.queryItems = queryItems
            return networkClient.request(
                type: CurrentWeatherResponse.self,
                url: endpoint.url,
                headers: endpoint.headers)
        } else {
            var endpoint = EndpointPlugin.currentWeather
            let queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: "b0592d72052843dffd9aab55423a04a0")
            ]
            endpoint.queryItems = queryItems
            return networkClient.request(
                type: CurrentWeatherResponse.self,
                url: endpoint.url,
                headers: endpoint.headers)
        }
    }
    
    func getForecastFive(lat: String? = nil, lon: String? = nil, city: String? = nil) -> AnyPublisher<ForecastResponse, Error> {
        if city?.isEmpty ?? false || city == nil {
            var endpoint = EndpointPlugin.forecastFive
            let urlqueryItems = [
                URLQueryItem(name: "lat", value: lat),
                URLQueryItem(name: "lon", value: lon),
                URLQueryItem(name: "cnt", value: "7"),
                URLQueryItem(name: "appid", value: "b0592d72052843dffd9aab55423a04a0")
            ]
            endpoint.queryItems = urlqueryItems
            return networkClient.request(
                type: ForecastResponse.self,
                url: endpoint.url,
                headers: endpoint.headers)
        } else {
            var endpoint = EndpointPlugin.forecastFive
            let urlqueryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "cnt", value: "7"),
                URLQueryItem(name: "appid", value: "b0592d72052843dffd9aab55423a04a0")
            ]
            endpoint.queryItems = urlqueryItems
            return networkClient.request(
                type: ForecastResponse.self,
                url: endpoint.url,
                headers: endpoint.headers)
        }
    }
}
