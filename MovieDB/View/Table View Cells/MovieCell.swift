//
//  MovieCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

protocol MovieCellDelegate {
    
    func didTapBook()
}

class MovieCell: UITableViewCell {
    
    
    //MARK: - Properties & Variables
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let bookButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.setTitle("Book", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = UIColor(red: 51/255, green: 53/255, blue: 68/255, alpha: 1.0)
        return button
    }()
    
    var delegate: MovieCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Custom Methods
    
    func setupViews() {
        
        addSubview(posterImageView)
        posterImageView.image = #imageLiteral(resourceName: "thumbnail")
        posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        addSubview(releaseDateLabel)
        releaseDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        addSubview(bookButton)
        bookButton.addTarget(self, action: #selector(bookButtonTapped), for: .touchUpInside)
        bookButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        bookButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        bookButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        bookButton.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: -5).isActive = true
    }
    
    @objc func bookButtonTapped() {
        
        if let localDelegate = delegate {
            localDelegate.didTapBook()
        }
    }
    
}
