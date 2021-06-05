//
//  SysCurrentResponse.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation

struct SysCurrentResponse: Codable {
    
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case type
        case id
        case country
        case sunrise
        case sunset
    }
}
