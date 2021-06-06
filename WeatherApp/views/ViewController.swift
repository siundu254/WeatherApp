//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {

    lazy var viewModel: CurrentWeatherViewModel = {
        let viewModel = CurrentWeatherViewModel()
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadModel()
    }
    
    func loadModel() {
        viewModel.$currentWeather.sink{[weak self] current in
        }.store(in: &cancellables)
    }
}

