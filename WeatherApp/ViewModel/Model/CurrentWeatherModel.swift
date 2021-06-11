//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 10/06/2021.
//

import Foundation

struct CurrentWeatherModel {
    let dt: String
    let icon: String
    let main: String
    let max_temp: String
    let min_temp: String
    let name: String
    let temp: String
    let lat: String?
    let lon: String?
    
    init(dt: String, icon: String, main: String, max_temp: String, min_temp: String, name: String, temp: String, lat: String? = nil, lon: String? = nil) {
        self.dt = dt
        self.icon = icon
        self.main = main
        self.max_temp = max_temp
        self.min_temp = min_temp
        self.name = name
        self.temp = temp
        self.lat = lat
        self.lon = lon
    }
}
