//
//  ForecastListResponse.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation

struct ForecastListResponse: Codable {
    let dt: Int
    let weather: [WeatherCurrentResponse]
    let temp: ForecastTempResponse
}
