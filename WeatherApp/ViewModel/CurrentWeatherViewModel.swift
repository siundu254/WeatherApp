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
    
    init(model: CurrentWeatherModel?) {
        self.state.currentWeather = model
    }
    
    var kind: Kind {
        let condition = self.state.currentWeather?.main.lowercased()
        if condition == "rain" || condition == "rainny" {
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
        return self.state.currentWeather?.icon ?? "sun.max.fill"
    }
    
    func getTemperatureWithFormat(temp: Double) -> String {
        let temp = String(format: "%.0f", temp - 273.15)
        return "\(temp)°"
    }
    
    var temperature: String {
        let temp = Double(self.state.currentWeather?.temp ?? "0") ?? 0.0
        let formattedTemp = getTemperatureWithFormat(temp: temp)
        return "\(formattedTemp)"
    }
    
    var conditions: String {
        return self.state.currentWeather?.main ?? "sunny"
    }
    
    var minTemperature: String {
        let minTemp = Double(self.state.currentWeather?.min_temp ?? "0") ?? 0.0
        let formattedTemp = getTemperatureWithFormat(temp: minTemp)
        return "\(formattedTemp)"
    }
    
    var maxTemperature: String {
        let maxTemp = Double(self.state.currentWeather?.max_temp ?? "0") ?? 0.0
        let formattedTemp = getTemperatureWithFormat(temp: maxTemp)
        return "\(formattedTemp)"
    }
    
    var cityName: String {
        return self.state.currentWeather?.name ?? "San Francisco, CA"
    }
    
    struct State {
        var currentWeather: CurrentWeatherModel?
    }
    
}

