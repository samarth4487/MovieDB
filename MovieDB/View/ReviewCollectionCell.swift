//
//  ReviewCollectionCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 28/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class ReviewCollectionCell: UICollectionViewCell {
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 6
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.masksToBounds = true
        layer.cornerRadius = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(authorLabel)
        authorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        authorLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        addSubview(reviewLabel)
        reviewLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor).isActive = true
        reviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        reviewLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor).isActive = true
        reviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
}
