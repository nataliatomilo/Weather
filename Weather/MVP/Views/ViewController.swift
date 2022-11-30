import Foundation
import UIKit

class ViewController: UIViewController {
    
    lazy var presenter = Presenter(with: self)
    
    let cityLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let weatherLabel: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let weatherNowView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        return view
    }()
    
    let tableViewForWeatherNow: UITableView! = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        return view
    }()
    
    let weatherView: UIView! = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.backgroundColor = UIColor(named: "#3C4E65")
        return view
    }()
    
    let tableViewForWeatherView: UITableView! = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        return view
    }()
    
    let cellForDescription = "cellForDescription"
    let cellWeatherPerDay = "cellWeatherPerDay"
    let cellForecast = "cellForecast"
    let cellChangeDays = "cellChangeDays"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "#3C4E65")
        addSubview()
        addLayout()
        tableViewForWeatherNow.register(CellForDescription.self, forCellReuseIdentifier: cellForDescription)
        tableViewForWeatherNow.register(CellWeatherPerDay.self, forCellReuseIdentifier: cellWeatherPerDay)
        tableViewForWeatherView.register(CellForecast.self, forCellReuseIdentifier: cellForecast)
        tableViewForWeatherView.register(CellChangeDays.self, forCellReuseIdentifier: cellChangeDays)
        tableViewForWeatherNow.delegate = self
        tableViewForWeatherNow.dataSource = self
        tableViewForWeatherView.delegate = self
        tableViewForWeatherView.dataSource = self
        presenter.loadInit()
        cityLabel.attributedText = NSAttributedString(string: presenter.weatherInCity[0].city, attributes: [.font: UIFont(name: "Inter-Regular_Medium", size: 30) as Any, .foregroundColor: UIColor.white])
        weatherLabel.attributedText = NSAttributedString(string: presenter.weatherInCity[0].temperature, attributes: [.font: UIFont(name: "Inter-Regular_Medium", size: 16) as Any, .foregroundColor: UIColor.white.withAlphaComponent(0.6)])
    }
    
    func addSubview() {
        view.addSubview(cityLabel)
        view.addSubview(weatherLabel)
        view.addSubview(weatherNowView)
        weatherNowView.addSubview(tableViewForWeatherNow)
        view.addSubview(weatherView)
        weatherView.addSubview(tableViewForWeatherView)
    }
    
    func addLayout() {
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 61),
            weatherLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 6.28),
            weatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherNowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            weatherNowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            weatherNowView.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 57),
            weatherNowView.heightAnchor.constraint(equalToConstant: 180),
            tableViewForWeatherNow.leadingAnchor.constraint(equalTo: weatherNowView.leadingAnchor),
            tableViewForWeatherNow.trailingAnchor.constraint(equalTo: weatherNowView.trailingAnchor),
            tableViewForWeatherNow.topAnchor.constraint(equalTo: weatherNowView.topAnchor),
            tableViewForWeatherNow.bottomAnchor.constraint(equalTo: weatherNowView.bottomAnchor),
            weatherView.topAnchor.constraint(equalTo: weatherNowView.bottomAnchor, constant: 9),
            weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            weatherView.heightAnchor.constraint(equalToConstant: 438),
            tableViewForWeatherView.leadingAnchor.constraint(equalTo: weatherView.leadingAnchor),
            tableViewForWeatherView.trailingAnchor.constraint(equalTo: weatherView.trailingAnchor),
            tableViewForWeatherView.topAnchor.constraint(equalTo: weatherView.topAnchor),
            tableViewForWeatherView.bottomAnchor.constraint(equalTo: weatherView.bottomAnchor)
        ])
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tableViewForWeatherNow {
            return 2
        }
        return presenter.weatherOnWeek.count + 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewForWeatherNow {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellForDescription, for: indexPath) as? CellForDescription else {
                    return UITableViewCell()
                }
                cell.label.text = presenter.weatherInCity[indexPath.row].description
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellWeatherPerDay, for: indexPath) as? CellWeatherPerDay else {
                    return UITableViewCell()
                }
                return cell
            }
        } else {
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellChangeDays, for: indexPath) as? CellChangeDays else {
                    return UITableViewCell()
                }
                cell.image.image = UIImage(named: "Group 746")
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: cellForecast, for: indexPath) as? CellForecast else {
                    return UITableViewCell()
                }
                cell.labelOfDay.text = presenter.weatherOnWeek[indexPath.row - 1].date
                cell.image.image = UIImage(named: "cloud")
                cell.labelTempNight.text = String(presenter.weatherOnWeek[indexPath.row - 1].minTemperature)
                cell.labelTempDay.text = String(presenter.weatherOnWeek[indexPath.row - 1].maxTemperature)
                return cell
            }
        }
    }
}

extension ViewController: PresenterView {
    func weather(data: Weather) {
        self.presenter.weatherInCity.append(data)
    }
    
    func weatherOnTheDay(data: WeatherOnTheDay) {
        self.presenter.weatherNow.append(data)
    }
    
    func weatherForAllDays(data: WeatherForAllDays) {
        self.presenter.weatherOnWeek.append(data)
    }
    
}
