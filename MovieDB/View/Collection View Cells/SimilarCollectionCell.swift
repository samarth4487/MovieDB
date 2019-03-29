//
//  SimilarCollectionCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 28/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class SimilarCollectionCell: UICollectionViewCell {
    
    
    //MARK: - Properties & Variables
    
    let movieImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let movieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Custom Methods
    
    func setupViews() {
        
        addSubview(movieImageView)
        movieImageView.image = #imageLiteral(resourceName: "thumbnail")
        movieImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        addSubview(movieLabel)
        movieLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        movieLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        movieLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 5).isActive = true
        movieLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
