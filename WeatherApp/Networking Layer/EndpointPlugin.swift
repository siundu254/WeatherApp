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
        components.host = ""
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
        return EndpointPlugin(path: "")
    }
}

