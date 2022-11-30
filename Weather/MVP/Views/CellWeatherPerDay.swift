import Foundation
import UIKit

class CellWeatherPerDay: UITableViewCell {
    
    lazy var presenter = Presenter( with: self)
    
    var collectionView: UICollectionView = {
        let layuot = UICollectionViewFlowLayout()
        layuot.scrollDirection = .horizontal
        layuot.minimumLineSpacing = 2
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layuot)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CellForCollectionView.self, forCellWithReuseIdentifier: CellForCollectionView.reuseID)
        cv.backgroundColor = UIColor.clear
        cv.contentInset = UIEdgeInsets(top: -12, left: 5, bottom: 12, right: 0)
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setup() {
        presenter.loadInit()
        collectionView.dataSource = self
        collectionView.delegate = self
        contentView.addSubview(collectionView)
        contentView.backgroundColor = UIColor(named: "#3C4E65")
        contentView.layer.opacity = 0.6
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }
}
extension CellWeatherPerDay: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 85)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.weatherNow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellForCollectionView.reuseID, for: indexPath) as? CellForCollectionView
        cell?.label.text = presenter.weatherNow[indexPath.row].timestamp
        if presenter.weatherNow[indexPath.row].sunset == true {
            cell?.imageView.image = UIImage(named: "fi_sunset")
            cell?.labelForTemp.text = "Заход солнца"
        } else {
            cell?.imageView.image = UIImage(named: "cloud")
            cell?.labelForTemp.text = presenter.weatherNow[indexPath.row].temperature
        }
        return cell!
    }
}

extension CellWeatherPerDay: PresenterView {
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
