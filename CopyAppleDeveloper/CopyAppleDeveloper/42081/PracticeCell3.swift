/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Cell for displaying a video
*/

import UIKit

class PracticeCell3: UICollectionViewCell {

    static let reuseIdentifier = "practice-cell-reuse-identifier"
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let categoryLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    /*
     init앞에 required를 붙이면, 필수 구현 메소드가 되면서, 모든 자손들이 해당 초기화 메소드를 구현해야 한다.
     반드시 오버라이딩 되어야 하는 것이므로, 별도로 override를 붙이지 않는다.
     */
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension PracticeCell3 {
    func configure() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.numberOfLines = 2
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        imageView.frame.size = CGSize(width: frame.height, height: frame.height * 0.8)
        
        titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        titleLabel.adjustsFontForContentSizeCategory = true
        categoryLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        categoryLabel.adjustsFontForContentSizeCategory = true
        categoryLabel.textColor = .placeholderText

        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = UIColor.systemPurple
       
        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
    }
}
