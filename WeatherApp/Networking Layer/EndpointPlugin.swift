//
//  EndpointPlugin.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import Foundation

struct EndpointPlugin {
    var path: String
    var queryItems: [URLQueryItem] = []
}

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
//        let defaults = UserDefaults.standard
        
        let path = "data/2.5/weather"
        
        let queryItems = [
            URLQueryItem(name: "lat", value: "35" ),
            URLQueryItem(name: "lon", value: "139"),
            URLQueryItem(name: "appid", value: "b0592d72052843dffd9aab55423a04a0")
        ]
        return EndpointPlugin(path: path, queryItems: queryItems)
    }
    
    static var forecastFive: Self {
        let path = "data/2.5/forecast"
        let queryItems = [
            URLQueryItem(name: "lat", value: "35" ),
            URLQueryItem(name: "lon", value: "139"),
            URLQueryItem(name: "cnt", value: "5"),
            URLQueryItem(name: "appid", value: "b0592d72052843dffd9aab55423a04a0")
        ]
        return EndpointPlugin(path: path, queryItems: queryItems)
    }
}

