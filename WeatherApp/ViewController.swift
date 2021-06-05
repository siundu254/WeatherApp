//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    var subscriptions = Set<AnyCancellable>()
    var currentWeather: CurrentWeatherResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
        let networkClient = NetworkClient()
        let weatherRepo = WeatherRepository(networkClient: networkClient)
        
        weatherRepo.getCurrentWeather().sink(receiveCompletion: { (completion) in
            switch completion {
            case let .failure(error):
                print("Error = \(error.localizedDescription)")
            case .finished: break
            }
        }) { current in
            print("Weather = \(current)")
        }.store(in: &subscriptions)
    }


}

