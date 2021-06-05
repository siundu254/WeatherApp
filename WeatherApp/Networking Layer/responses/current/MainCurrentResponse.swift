//
//  MainCurrentResponse.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation

struct MainCurrentResponse: Codable {
    let temp: Double
    let feels_like: Double
    let temp_main: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
    
    private enum CodingKeys: String, CodingKey {
        case temp
        case feels_like
        case temp_main
        case temp_max
        case pressure
        case humidity
    }
}
