import Foundation
import UIKit

struct Weather {
    let city: String
    let temperature: String
    let description: String
}

struct WeatherOnTheDay {
    let timestamp: String
    let weatherType: String
    let temperature: String
    let sunset: Bool?
}

struct WeatherForAllDays {
    let date: String
    let minTemperature: Int
    let maxTemperature: Int
    let weatherType: String
}
