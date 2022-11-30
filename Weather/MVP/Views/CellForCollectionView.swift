import Foundation
import UIKit

class CellForCollectionView: UICollectionViewCell {
    static let reuseID = "CollectionViewCell"
    
    let label: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView! = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let labelForTemp: UILabel! = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.addSubview(imageView)
        contentView.addSubview(labelForTemp)
        label.textColor = .white
        label.font = UIFont(name: "Inter-Regular_Medium", size: 14)
        labelForTemp.textColor = .white
        labelForTemp.font = UIFont(name: "Inter-Regular_Medium", size: 16)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 9.74),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelForTemp.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 19),
            labelForTemp.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
