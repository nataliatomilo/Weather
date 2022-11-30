import Foundation
import UIKit

protocol PresenterView: AnyObject {
    func weather(data: Weather)
    func weatherOnTheDay(data: WeatherOnTheDay)
    func weatherForAllDays(data: WeatherForAllDays)
    
}

class Presenter {
    weak var delegate: PresenterView?
    var weatherInCity = [Weather]()
    var weatherNow = [WeatherOnTheDay]()
    var weatherOnWeek = [WeatherForAllDays]()
    
    init(with view: PresenterView) {
        self.delegate = view
    }
    
    public func loadInit() {
        let fileName = Bundle.main.url(forResource: "TestTaskJSON", withExtension: "json")
        let placesData = try? Data(contentsOf: fileName!)
        let air = try! JSONSerialization.jsonObject(with: placesData!, options: []) as? Dictionary<String, Any>
        for _ in air! {
            if let city = air!["city"] as? String,
               let temperature = air!["temperature"] as? String,
               let description = air!["description"] as? String {
                self.delegate?.weather(data: Weather(city: city, temperature: temperature, description: description))
            }
        }
        if let weatherPerDay = air!["weather_per_day"] as? [Dictionary <String, Any>] {
            for day in weatherPerDay {
                if let timestamp = day["timestamp"] as? String,
                   let weatherType = day["weather_type"] as? String,
                   let temperature = day["temperature"] as? String,
                   let sunset = day["sunset"] as? Bool? {
                    self.delegate?.weatherOnTheDay(data: WeatherOnTheDay(timestamp: timestamp, weatherType: weatherType, temperature: temperature, sunset: sunset))
                }
            }
            if let forecast = air!["forecast"] as? [Dictionary<String, Any>] {
                for new in forecast {
                    if let date = new["date"] as? String,
                       let minTemperature = new["min_temperature"] as? Int,
                       let maxTemperature = new["max_temperature"] as? Int,
                       let weatherType = new["weather_type"] as? String {
                        self.delegate?.weatherForAllDays(data: WeatherForAllDays(date: date, minTemperature: minTemperature, maxTemperature: maxTemperature, weatherType: weatherType))
                    }
                }
            }
        }
    }
}
