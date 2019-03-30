//
//  MovieCoverCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class MovieCoverCell: UITableViewCell {
    
    
    //MARK: - Properties & Variables
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Custom Methods
    
    func setupViews() {
        
        addSubview(posterImageView)
        posterImageView.image = #imageLiteral(resourceName: "thumbnail")
        posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

}
