//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 06/06/2021.
//

import Foundation
import Combine

class CurrentWeatherViewModel: ObservableObject {
    
    let didChange = PassthroughSubject<CurrentWeatherResponse, Never>()
    var subscriptions = Set<AnyCancellable>()
    let networkClient = NetworkClient()
    
    @Published var currentWeather: CurrentWeatherResponse?
    @Published var forecastWeather: ForecastResponse?
    
    init() {
        // get Current Weather and Forecast data
        getCurrentWeather()
        getForecastFive()
    }
    
    func getCurrentWeather() {
        let weatherRepo = WeatherRepository(networkClient: networkClient)
        weatherRepo.getCurrentWeather().sink(receiveCompletion: { (completion) in
            switch completion {
            case let .failure(error):
                // error decoding data
                print("Error = \(error.localizedDescription)")
            case .finished: break
            }
        }) { current in
            self.currentWeather = current
        }.store(in: &subscriptions)
    }
    
    func getForecastFive() {
        let weatherRepo = WeatherRepository(networkClient: networkClient)
        weatherRepo.getForecastFive().sink(receiveCompletion: { (completion) in
            switch completion {
            case let .failure(error):
                print("Error = \(error.localizedDescription)")
            case .finished: break
            }
        }) { forecast in
            self.forecastWeather = forecast
        }.store(in: &subscriptions)
    }

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    var weatherIcon: String {
        if self.currentWeather?.weather.count ?? 0 > 0 {
            return self.currentWeather?.weather[0].icon ?? "sun.max.fill"
        }
        return "sun.max.fill"
    }
    
    func getTemperatureWithFormat(temp: Double) -> String {
        return String(format: "%.0f", temp)
    }
    
    var temperature: String {
        return getTemperatureWithFormat(temp: self.currentWeather?.main.temp ?? 0.0)
    }
    
    var conditions: String {
        if self.currentWeather?.weather.count ?? 0 > 0 {
            return self.currentWeather?.weather[0].main ?? "sunny"
        }
        
        return "sunny"
    }
    
    var minTemperature: String {
        return getTemperatureWithFormat(temp: self.currentWeather?.main.temp_min ?? 0.0)
    }
    
    var maxTemperature: String {
        return getTemperatureWithFormat(temp: self.currentWeather?.main.temp_max ?? 0.0)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
}

