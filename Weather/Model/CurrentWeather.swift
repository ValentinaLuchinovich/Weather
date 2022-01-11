//
//  CurrentWeather.swift
//  Weather
//
//  Created by Валентина Лучинович on 11.01.2022.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        return "\(temperature.rounded())"
    }
    let feelsLiketemperature: Double
    var feelsLiketemperatureString: String {
        return "\(feelsLiketemperature.rounded())"
    }
    let conditionCode: Int
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLiketemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
         
    }
}
