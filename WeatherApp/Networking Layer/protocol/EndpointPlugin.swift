//
//  EndpointPlugin.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation


// A handy struct that has path and queryItems properties
struct EndpointPlugin {
    var path: String
    var queryItems: [URLQueryItem] = []
}

// By defining an extension on our struct we can easily
// create the base URL of our REST API's
// define specific endpoints and headers
extension EndpointPlugin {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure()
        }
        
        return url
    }
    
    var headers: [String: Any] {
        return [:]
    }
}

extension EndpointPlugin {
    
    static var baseURL: Self {
        return EndpointPlugin(path: "")
    }
    
    static var currentWeather: Self {
        let path = "data/2.5/weather"
        return EndpointPlugin(path: path)
    }
    
    static var forecastFive: Self {
        let path = "data/2.5/forecast/daily"
        return EndpointPlugin(path: path)
    }
}

