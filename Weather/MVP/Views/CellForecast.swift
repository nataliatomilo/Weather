import Foundation
import UIKit

class CellForecast: UITableViewCell {
    let labelOfDay = UILabel(frame: .zero)
    let image = UIImageView(frame: .zero)
    let labelTempNight = UILabel(frame: .zero)
    let labelTempDay = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setup() {
        contentView.backgroundColor = UIColor(named: "#3C4E65")
        contentView.layer.opacity = 0.6
        labelOfDay.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        labelTempNight.translatesAutoresizingMaskIntoConstraints = false
        labelTempDay.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelOfDay)
        contentView.addSubview(image)
        contentView.addSubview(labelTempNight)
        contentView.addSubview(labelTempDay)
        labelOfDay.textColor = .white
        labelOfDay.font = UIFont(name: "Inter-Regular_Medium", size: 18)
        labelTempDay.textColor = .white
        labelTempDay.font = UIFont(name: "Inter-Regular_Medium", size: 16)
        labelTempNight.font = UIFont(name: "Inter-Regular_Medium", size: 16)
        labelTempNight.textColor = UIColor(named: "#95A1B1")
        
        NSLayoutConstraint.activate([
            labelOfDay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            labelOfDay.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelTempNight.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelTempNight.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 60),
            labelTempDay.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelTempDay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.5)
        ])
    }
}
