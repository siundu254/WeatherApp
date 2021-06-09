//
//  CurrentWeatherViewModel.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 06/06/2021.
//

import Foundation

class CurrentWeatherViewModel {
    private var state = State()
    
    enum Kind {
        case sunny
        case rainy
        case cloudy
        case other
    }
    
    init(model: CurrentWeatherResponse?) {
        self.state.currentWeather = model
    }
    
    var kind: Kind {
        let condition = self.state.currentWeather?.weather[0].main.lowercased()
        if condition == "rain" {
            return .rainy
        } else if condition == "cloudy" || condition == "clouds" {
            return .cloudy
        } else if condition == "clear" {
            return .sunny
        } else {
            return .other
        }
    }
    
    var weatherIcon: String {
        if self.state.currentWeather?.weather.count ?? 0 > 0 {
            return self.state.currentWeather?.weather[0].icon ?? "sun.max.fill"
        }
        return "sun.max.fill"
    }
    
    func getTemperatureWithFormat(temp: Double) -> String {
        let temp = String(format: "%.0f", temp - 273.15)
        return "\(temp)°"
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
    
    var cityName: String {
        return self.state.currentWeather?.name ?? "San Francisco, CA"
    }
    
    struct State {
        var currentWeather: CurrentWeatherResponse?
    }
    
}

