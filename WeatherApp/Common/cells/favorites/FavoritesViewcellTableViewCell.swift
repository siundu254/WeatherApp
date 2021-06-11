//
//  FavoritesViewcellTableViewCell.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 11/06/2021.
//

import UIKit

class FavoritesViewcellTableViewCell: UITableViewCell {
    @IBOutlet weak var favoritesName: UILabel!
    @IBOutlet weak var favoritesTemp: UILabel!
    @IBOutlet weak var favoritesImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with model: CurrentWeatherModel) {
        let viewModel = CurrentWeatherViewModel(model: model)
        
        
        favoritesName.text = viewModel.cityName
        favoritesTemp.text = viewModel.temperature
        
        let urlString = NSURL(string: "https://openweathermap.org/img/w/\(viewModel.weatherIcon).png")
        let urlData = NSData(contentsOf: urlString! as URL)

        if urlData != nil {
            favoritesImage.image = UIImage(data: urlData! as Data)
        }
    }
    
}
