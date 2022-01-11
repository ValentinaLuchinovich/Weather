//
//  NetworkWetherManager.swift
//  Weather
//
//  Created by Валентина Лучинович on 10.01.2022.
//

import Foundation

struct  NetworkWetherManager {
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)"
        // Преобразуем строку в URL
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        // Создаем запрос
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                let dataString = String(data: data, encoding: .utf8)
                print(dataString!)
            }
        }
        task.resume()
    }
}
