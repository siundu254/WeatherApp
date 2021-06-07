//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var state = State()
    var subscriptions = Set<AnyCancellable>()
    let networkClient = NetworkClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCurrentWeather()
    }
    
    func getCurrentWeather() {
        let weatherRepo = WeatherRepository(networkClient: networkClient)
        weatherRepo.getCurrentWeather()
            .sink(
                receiveCompletion: {(completion) in
                    switch completion {
                    case let .failure(error):
                        print("Error = \(error.localizedDescription)")
                    case .finished: break
                    }
                },
                receiveValue: {(current) in
                    self.state.currentWeather = current
                    self.updateUI(model: current)
                })
            .store(in: &subscriptions)
    }
    
    func updateUI(model: CurrentWeatherResponse) {
        let model = CurrentWeatherViewModel(model: self.state.currentWeather)
        print("conditions = \(model.conditions)")
    }
    
    struct State {
        var currentWeather: CurrentWeatherResponse?
        var forecastWeather: ForecastResponse?
    }
}

