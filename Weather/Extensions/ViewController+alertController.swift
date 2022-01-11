//
//  ViewController+alertController.swift
//  Weather
//
//  Created by Валентина Лучинович on 10.01.2022.
//

import UIKit

extension ViewController {
    func presentSearchAlertController(withTitle title: String?, message: String?, style: UIAlertController.Style) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style)
        ac.addTextField { tf in
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            tf.placeholder = cities.randomElement()
        }
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = ac.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                // В случае если город состоит из двух слов он должен читаться программой
                // Для этого вместо пробела будет использоваться %20
                let city = cityName.split(separator: " ").joined(separator: "%20")
                // Привязываем данные о погоде к кнопке поиска
                self.networkWeatherManager.fetchCurrentWeather(forCity: city)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(search)
        ac.addAction(cancel)
        present(ac, animated: true, completion: nil)
    }
}
