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
}

final class WeatherRepository: WeatherRepositoryProtocol {
    let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func getCurrentWeather() -> AnyPublisher<CurrentWeatherResponse, Error> {
        let endpoint = EndpointPlugin.currentWeather
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b0592d72052843dffd9aab55423a04a0")!
        return networkClient.request(
            type: CurrentWeatherResponse.self,
            url: url,
            headers: endpoint.headers)
    }
}
