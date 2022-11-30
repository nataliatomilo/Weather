import Foundation
import UIKit

class CellForDescription: UITableViewCell {
    let label = UILabel(frame: .zero)
    
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
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont(name: "Inter-Regular_Medium", size: 14)
        contentView.backgroundColor = UIColor(named: "#3C4E65")
        contentView.layer.opacity = 0.6
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14)
        ])
    }
}
