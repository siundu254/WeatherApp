//
//  CloudsCurrentResponse.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation

struct CloudsCurrentResponse {
    let all: Int
    
    enum CodingKeys: String, CodingKey {
        case all
    }
}
