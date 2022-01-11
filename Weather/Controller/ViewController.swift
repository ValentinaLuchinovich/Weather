//
//  ViewController.swift
//  Weather
//
//  Created by Валентина Лучинович on 10.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    var networkWeatherManager = NetworkWetherManager()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        self.presentSearchAlertController(withTitle: "Enter city name", message: nil, style: .alert) { city in
            self.networkWeatherManager.fetchCurrentWeather(forCity: city)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkWeatherManager.onCompletion = { currentWeather in
            print(currentWeather.cityName)
        }
        networkWeatherManager.fetchCurrentWeather(forCity: "London")
    }
}

