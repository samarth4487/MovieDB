//
//  MovieSynopsisCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class MovieSynopsisCell: UITableViewCell {
    
    let synopsisLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(synopsisLabel)
        synopsisLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        synopsisLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        synopsisLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        synopsisLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }

}
