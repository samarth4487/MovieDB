//
//  MovieCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        addSubview(posterImageView)
        posterImageView.backgroundColor = .black
        posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(titleLabel)
        titleLabel.backgroundColor = .black
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        addSubview(releaseDateLabel)
        releaseDateLabel.backgroundColor = .black
        releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        addSubview(bookButton)
        bookButton.backgroundColor = .black
        bookButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 60).isActive = true
        bookButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bookButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        bookButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -5).isActive = true
    }
    
}
