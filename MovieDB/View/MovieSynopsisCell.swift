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
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 51/255, green: 53/255, blue: 68/255, alpha: 1.0)
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
