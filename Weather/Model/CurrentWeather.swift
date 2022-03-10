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
        // Округляем значение температуры
        // Цифра после знака % указывает кол-во знаков после запятой
        return String(format: "%.0f", temperature)
    }
    let feelsLiketemperature: Double
    var feelsLiketemperatureString: String {
        return String(format: "%.0f", feelsLiketemperature)
    }
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...231:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 800...804:
            return "smoke.fill"
        default:
            return "nosign"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLiketemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
