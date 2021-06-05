//
//  WindCurrentResponse.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation

struct WindCurrentResponse: Codable {
    let speed: Double
    let deg: Double
    let gust: Double
}
