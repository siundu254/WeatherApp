//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation

// Simple objects that can be created from our JSON
struct CurrentWeatherResponse: Codable {
    let weather: [WeatherCurrentResponse]
    let main: MainCurrentResponse
    let name: String
    let dt: Int
    let coord: CoordCurrentResponse
}
