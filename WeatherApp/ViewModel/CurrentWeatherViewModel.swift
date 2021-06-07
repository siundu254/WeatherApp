//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 06/06/2021.
//

import Foundation
import Combine

class CurrentWeatherViewModel {
    private var state = State()
    
    init(model: CurrentWeatherResponse?) {
        self.state.currentWeather = model
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
        if self.state.currentWeather?.weather.count ?? 0 > 0 {
            return self.state.currentWeather?.weather[0].icon ?? "sun.max.fill"
        }
        return "sun.max.fill"
    }
    
    func getTemperatureWithFormat(temp: Double) -> String {
        return String(format: "%.0f", temp)
    }
    
    var temperature: String {
        if self.state.currentWeather?.main.temp ?? 0.0 > 0 {
            return getTemperatureWithFormat(temp: self.state.currentWeather?.main.temp ?? 0.0)
        }
        return "0.0"
    }
    
    var conditions: String {
        if self.state.currentWeather?.weather.count ?? 0 > 0 {
            return self.state.currentWeather?.weather[0].main ?? "sunny"
        }
        
        return "sunny"
    }
    
    var minTemperature: String {
        return getTemperatureWithFormat(temp: self.state.currentWeather?.main.temp_min ?? 0.0)
    }
    
    var maxTemperature: String {
        return getTemperatureWithFormat(temp: self.state.currentWeather?.main.temp_max ?? 0.0)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    struct State {
        var currentWeather: CurrentWeatherResponse?
        var forecastWeather: ForecastResponse?
    }
    
}

