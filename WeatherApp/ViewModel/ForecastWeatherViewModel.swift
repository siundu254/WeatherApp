//
//  ForecastWeatherViewModel.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 08/06/2021.
//

import Foundation

class ForecastWeatherViewModel {
    
    private var state = State()
    
    enum Kind {
        case sunny
        case rainy
        case cloudy
        case other
    }
    
    init(forecast: ForecastListResponse?) {
        self.state.forecastWeather = forecast
    }
    
    var temperature: String {
        if self.state.forecastWeather?.temp.day ?? 0.0 > 0 {
            return getTemperatureWithFormat(temp: self.state.forecastWeather?.temp.day ?? 0.0)
        }
        return "0.0"
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
    
    func getTemperatureWithFormat(temp: Double) -> String {
        let temp = String(format: "%.0f", temp - 273.15)
        return "\(temp)°"
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: Double(timestamp)))
    }
    
    var getDayToday: String {
        return getDayFor(timestamp: self.state.forecastWeather?.dt ?? 0)
    }
    
    var weatherTypeImage: String {        
        return self.state.forecastWeather?.weather[0].icon ?? "09d"
    }
    
    var kind: Kind {
        let condition = self.state.forecastWeather?.weather[0].main.lowercased()
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
    
    struct State {
        var forecastWeather: ForecastListResponse?
    }
}
