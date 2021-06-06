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
        let defaults = UserDefaults.standard
        let lat = defaults.object(forKey: "latitude")
        let lon = defaults.object(forKey: "longitude")
        
        let path = "data/2.5/weather"
        
        let queryItems = [
            URLQueryItem(name: "lat", value: "\(lat ?? "35")"),
            URLQueryItem(name: "lon", value: "\(lon ?? "139")"),
            URLQueryItem(name: "appid", value: "b0592d72052843dffd9aab55423a04a0")
        ]
        return EndpointPlugin(path: path, queryItems: queryItems)
    }
    
    static var forecastFive: Self {
        let defaults = UserDefaults.standard
        let lat = defaults.object(forKey: "latitude")
        let lon = defaults.object(forKey: "longitude")
        
        let path = "data/2.5/forecast"
        let queryItems = [
            URLQueryItem(name: "lat", value: "\(lat ?? "35")"),
            URLQueryItem(name: "lon", value: "\(lon ?? "139")"),
            URLQueryItem(name: "cnt", value: "5"),
            URLQueryItem(name: "appid", value: "b0592d72052843dffd9aab55423a04a0")
        ]
        return EndpointPlugin(path: path, queryItems: queryItems)
    }
}

