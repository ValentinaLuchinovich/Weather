//
//  NetworkWetherManager.swift
//  Weather
//
//  Created by Валентина Лучинович on 10.01.2022.
//

import Foundation
import CoreLocation

class  NetworkWetherManager {
    
    enum ReqestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    }
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    // Универсальный метод для получения данных и по названию города, и по координатам
    func fetchCurrentWeather(forRequestType requestType: ReqestType) {
        var urlString = ""
        switch requestType {
        case .cityName(let city):
            urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        }
        performRequest(with: urlString)
    }
    
//    // Получение данных по названию города
//    func fetchCurrentWeather(forCity city: String) {
//        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
//        performRequest(with: urlString)
//    }
//
//    // Получение данных по широте и долготе
//    func fetchCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let urlString = "api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
//        performRequest(with: urlString)
//    }
    
    fileprivate func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentWeather = self.parseJSON(withData: data) {
                    self.onCompletion?(currentWeather)
                }
            }
        }
        task.resume()
    }
    
    // Метод отвечающий за парсинг JSON
    fileprivate func parseJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else {
                return nil
            }
            return currentWeather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
