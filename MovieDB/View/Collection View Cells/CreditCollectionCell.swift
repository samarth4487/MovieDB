//
//  CreditCollectionCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 28/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class CreditCollectionCell: UICollectionViewCell {
    
    
    //MARK: - Properties & Variables
    
    let characterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let nameLabel: UILabel = {
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
        
        addSubview(characterImageView)
        characterImageView.image = #imageLiteral(resourceName: "thumbnail")
        characterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        characterImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
