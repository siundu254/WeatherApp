//
//  ForecastWeatherModel.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 10/06/2021.
//

import Foundation

struct ForecastWeatherModel {
    let day: String
    let dt: String
    let icon: String
    let main: String
    
    init(day: String, dt: String, icon: String, main: String) {
        self.day = day
        self.dt = dt
        self.icon = icon
        self.main = main
    }
}
