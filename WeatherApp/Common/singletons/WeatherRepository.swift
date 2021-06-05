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
    
    func getCurrentWeather() -> AnyPublisher<CurrentWeatherResponse, Error>
    func getForecastFive() -> AnyPublisher<ForecastResponse, Error>
}

final class WeatherRepository: WeatherRepositoryProtocol {
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCurrentWeather() -> AnyPublisher<CurrentWeatherResponse, Error> {
        let endpoint = EndpointPlugin.currentWeather
        return networkClient.request(
            type: CurrentWeatherResponse.self,
            url: endpoint.url,
            headers: endpoint.headers)
    }
    
    func getForecastFive() -> AnyPublisher<ForecastResponse, Error> {
        let endpoint = EndpointPlugin.forecastFive
        return networkClient.request(
            type: ForecastResponse.self,
            url: endpoint.url,
            headers: endpoint.headers)
    }
}
