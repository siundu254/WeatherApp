//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation

struct ForecastResponse: Codable {
    let list: [ForecastListResponse]
}
