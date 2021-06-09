//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private var state = State(forecastWeather: [])
    var subscriptions = Set<AnyCancellable>()
    let networkClient = NetworkClient()
    
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var kindBackgorundImage: UIImageView!
    
    @IBOutlet weak var tempTitleLabel: UILabel!
    @IBOutlet weak var cityNameTitleLabel: UILabel!
    @IBOutlet weak var conditionsTitleLabel: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var forecastTableView: UITableView!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var stackMinView: UIView!
    @IBOutlet weak var stackMaxView: UIView!
    @IBOutlet weak var stackCurrentView: UIView!
    @IBOutlet weak var tempStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        indicatorView.startAnimating()
        
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.register(UINib(nibName: "ForecastViewCell", bundle: nil), forCellReuseIdentifier: "ForecastViewCell")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getCurrentWeather()
        getForecastFive()
    }
    
    func getCurrentWeather() {
        let weatherRepo = WeatherRepository(networkClient: networkClient)
        DispatchQueue.main.async {
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
                        self.updateCurrentUI(model: current)
                    })
                .store(in: &self.subscriptions)
        }
    }
    
    func getForecastFive() {
        let weatherRepo = WeatherRepository(networkClient: networkClient)
        DispatchQueue.main.async {
            weatherRepo.getForecastFive()
                .sink(
                    receiveCompletion: {(completion) in
                        switch completion {
                        case let .failure(error):
                            print("Error = \(error.localizedDescription)")
                        case .finished: break
                        }
                    },
                    receiveValue: {(forecast) in
                        self.updateForecastUI(model: forecast)
                    })
                .store(in: &self.subscriptions)
        }
    }
    
    func updateCurrentUI(model: CurrentWeatherResponse) {
        let model = CurrentWeatherViewModel(model: self.state.currentWeather)
        DispatchQueue.main.async {
            self.conditionsTitleLabel.text = model.conditions
            self.tempTitleLabel.text = model.temperature
            self.cityNameTitleLabel.text = model.cityName
            
            self.currentTempLabel.text = model.temperature
            self.minTempLabel.text = model.minTemperature
            self.maxTempLabel.text = model.maxTemperature
            
            switch model.kind {
            case .cloudy:
                self.kindBackgorundImage.image = UIImage(named: "sea_cloudy")
                self.backgroundView.backgroundColor = UIColor.seaCloudy
                self.forecastTableView.backgroundColor = UIColor.seaCloudy
                
                self.stackMinView.backgroundColor = UIColor.seaCloudy
                self.stackMaxView.backgroundColor = UIColor.seaCloudy
                self.stackCurrentView.backgroundColor = UIColor.seaCloudy
                self.tempStackView.backgroundColor = UIColor.seaCloudy
            case .rainy:
                self.kindBackgorundImage.image = UIImage(named: "sea_rainy")
                self.backgroundView.backgroundColor = UIColor.seaRainny
                self.forecastTableView.backgroundColor = UIColor.seaRainny
                
                self.stackMinView.backgroundColor = UIColor.seaRainny
                self.stackCurrentView.backgroundColor = UIColor.seaRainny
                self.stackMaxView.backgroundColor = UIColor.seaRainny
                self.tempStackView.backgroundColor = UIColor.seaRainny
            case .sunny:
                self.kindBackgorundImage.image = UIImage(named: "sea_sunny")
                self.backgroundView.backgroundColor = UIColor.seaSunny
                self.forecastTableView.backgroundColor = UIColor.seaSunny
                
                self.stackCurrentView.backgroundColor = UIColor.seaSunny
                self.stackMaxView.backgroundColor = UIColor.seaSunny
                self.stackMinView.backgroundColor = UIColor.seaSunny
                self.tempStackView.backgroundColor = UIColor.seaSunny
            case .other: break
            }
        }
    }
    
    func updateForecastUI(model: ForecastResponse) {
        DispatchQueue.main.async {
            for i in model.list.indices {
                self.state.forecastWeather.append(model.list[i])
            }
            self.forecastTableView.reloadData()
            self.indicatorView.stopAnimating()
        }
    }
    
    struct State {
        var currentWeather: CurrentWeatherResponse?
        var forecastWeather: [ForecastListResponse]
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.state.forecastWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastViewCell", for: indexPath) as! ForecastViewCell
        cell.configure(with: self.state.forecastWeather[indexPath.row])
        return cell
    }
    
    
}
