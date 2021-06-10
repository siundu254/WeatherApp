//
//  ViewController.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import UIKit
import CoreData
import Combine
import Firebase

class ViewController: UIViewController {
    
    private var state = State(forecastWeather: [], forecastModel: [])
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
    var weatherRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Database.database().isPersistenceEnabled = true
        
        indicatorView.startAnimating()
        forecastTableView.delegate = self
        forecastTableView.dataSource = self
        forecastTableView.register(UINib(nibName: "ForecastViewCell", bundle: nil), forCellReuseIdentifier: "ForecastViewCell")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser == nil {
            getCurrentWeather()
            getForecastFive()
        } else {
            let user = Auth.auth().currentUser
            // check for Data in DB
            weatherRef = Database.database().reference()
            weatherRef.child("users").child(user?.uid ?? "").observe(.value, with:{ snapshot in
                if snapshot.exists() {
                    self.getCurrentData()
                    self.getForecastData()
                } else {
                    self.getCurrentWeather()
                    self.getForecastFive()
                }
            })
        }
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
                        // save data to firebase and create anonymous user
                        Auth.auth().signInAnonymously{(authResult, error) in
                            let userId = authResult?.user.uid
                            self.saveDataToDB(userId ?? "", current)
                        }
                        
                    })
                .store(in: &self.subscriptions)
        }
    }
    
    func saveDataToDB(_ userId: String, _ current: CurrentWeatherResponse) {
        if !userId.isEmpty || userId.lowercased() != "" {
            weatherRef = Database.database().reference()
            
            let data: Dictionary<String, String> = [
                "name": current.name,
                "dt": "\(current.dt)",
                "temp": "\(current.main.temp ?? 0.0)",
                "min_temp": "\(current.main.temp_min ?? 0.0)",
                "max_temp": "\(current.main.temp_max ?? 0.0)",
                "icon": "\(current.weather[0].icon)",
                "main": "\(current.weather[0].main)"
            ]
            weatherRef.child("users").child(userId).child("current").setValue(data)
            self.getCurrentData()
        } else {
            print("uid is empty")
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
                        self.saveForecastData(forecast)
                    })
                .store(in: &self.subscriptions)
        }
    }
    
    func saveForecastData(_ forecast: ForecastResponse) {
        if Auth.auth().currentUser != nil {
            weatherRef = Database.database().reference()
            let userId = Auth.auth().currentUser?.uid ?? ""
            var data: [[String : Any]] = [[:]]
            
            for cast in forecast.list.indices {
                let forecast: [String : Any] = [
                    "dt": "\(forecast.list[cast].dt)",
                    "day": "\(forecast.list[cast].temp.day)",
                    "icon": forecast.list[cast].weather[0].icon,
                    "main": forecast.list[cast].weather[0].main
                ]
                
                data.append(forecast)
                weatherRef.child("users").child(userId).child("forecast").setValue(data)
                getForecastData()
            }
        } else {
            print("uid is empty")
        }
    }
    
    func getCurrentData() {
        weatherRef = Database.database().reference()
        let userId = Auth.auth().currentUser?.uid ?? ""
        weatherRef.child("users").child(userId).child("current").observe(.value, with: { snapshot in
            guard let values = snapshot.value as? [String : Any] else { return }
            
            let dt = values["dt"] as? String ?? ""
            let icon = values["icon"] as? String ?? ""
            let main = values["main"] as? String ?? ""
            let max_temp = values["max_temp"] as? String ?? ""
            let min_temp = values["min_temp"] as? String ?? ""
            let name = values["name"] as? String ?? ""
            let temp = values["temp"] as? String ?? ""
            
            self.updateCurrentUI(model: CurrentWeatherModel(dt: dt, icon: icon, main: main, max_temp: max_temp, min_temp: min_temp, name: name, temp: temp))
        })
        weatherRef.keepSynced(true)
    }
    
    func getForecastData() {
        weatherRef = Database.database().reference()
        let userId = Auth.auth().currentUser?.uid ?? ""
        var forecastModel = [ForecastWeatherModel]()
        
        weatherRef.child("users").child(userId).child("forecast").observe(.value, with: { snapshot in
            
            for child in snapshot.children {
                let value = child as! DataSnapshot
                let valueDict = value.value as! [String: Any]
                
                let day = valueDict["day"] as? String ?? ""
                let dt = valueDict["dt"] as? String ?? ""
                let icon = valueDict["icon"] as? String ?? ""
                let main = valueDict["main"] as? String ?? ""
                
                forecastModel.append(ForecastWeatherModel(day: day, dt: dt, icon: icon, main: main))
            }
            
            self.updateForecastUI(model: forecastModel)
        })
        weatherRef.keepSynced(true)
    }
    
    func updateCurrentUI(model: CurrentWeatherModel) {
        let model = CurrentWeatherViewModel(model: model)
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
    
    func updateForecastUI(model: [ForecastWeatherModel]) {
        DispatchQueue.main.async {
            self.state.forecastModel = model
            self.forecastTableView.reloadData()
            self.indicatorView.stopAnimating()
        }
    }
    
    struct State {
        var currentWeather: CurrentWeatherResponse?
        var forecastWeather: [ForecastListResponse]
        var currentModel: CurrentWeatherModel?
        var forecastModel: [ForecastWeatherModel]
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.state.forecastModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastViewCell", for: indexPath) as! ForecastViewCell
        cell.configure(with: self.state.forecastModel[indexPath.row])
        return cell
    }
    
    
}
