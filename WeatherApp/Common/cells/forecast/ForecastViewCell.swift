//
//  ForecastViewCell.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 08/06/2021.
//

import UIKit

class ForecastViewCell: UITableViewCell {
    
    @IBOutlet weak var firstSegmentView: UIView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var conditionsImage: UIImageView!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var secondSegmentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with model: ForecastWeatherModel) {
        let viewModel = ForecastWeatherViewModel(forecast: model)
        
        labelTemp.text = viewModel.temperature
        labelDate.text = viewModel.getDayToday
        
        let urlString = NSURL(string: "https://openweathermap.org/img/w/\(viewModel.weatherTypeImage).png")
        let urlData = NSData(contentsOf: urlString! as URL)
        
        if urlData != nil {
            conditionsImage.image = UIImage(data: urlData! as Data)
        }
        
        switch viewModel.kind {
        case .cloudy:
            firstSegmentView.backgroundColor = UIColor.seaCloudy
            secondSegmentView.backgroundColor = UIColor.seaCloudy
        case .rainy:
            firstSegmentView.backgroundColor = UIColor.seaRainny
            secondSegmentView.backgroundColor = UIColor.seaRainny
        case .sunny:
            firstSegmentView.backgroundColor = UIColor.seaSunny
            secondSegmentView.backgroundColor = UIColor.seaSunny
        case .other: break
        }
    }
    
}
