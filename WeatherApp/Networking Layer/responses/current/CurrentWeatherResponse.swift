//
//  CurrentWeatherResponse.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    let code: Int
    let base: String
    let visibility: Int
    let dt: Int
    let timezone: Int
    let id: Int
    let name: String
    let coord: CoordCurrentResponse
    let weather: [WeatherCurrentResponse]
    let main: MainCurrentResponse
//    let wind: WindCurrentResponse
//    let clouds: CloudsCurrentResponse
    let sys: SysCurrentResponse
    
    enum CodingKeys: String, CodingKey {
        case code
        case base
        case visibility
        case dt
        case timezone
        case id
        case name
        case coord
        case weather
        case main
//        case wind
//        case clouds
        case sys
    }
}
