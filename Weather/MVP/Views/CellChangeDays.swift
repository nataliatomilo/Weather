import Foundation
import UIKit

class CellChangeDays: UITableViewCell {
    let image = UIImageView(frame: .zero)
    
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
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        contentView.backgroundColor = UIColor(named: "#3C4E65")
        contentView.layer.opacity = 0.6
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17.17),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
    }
}
