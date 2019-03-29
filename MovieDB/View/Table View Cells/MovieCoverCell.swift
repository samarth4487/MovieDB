//
//  MovieCoverCell.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 27/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

protocol MoviewCoverCellDelegate {
    
    func didTapDismiss()
}

class MovieCoverCell: UITableViewCell {
    
    
    //MARK: - Properties & Variables
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    
    let dismissButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    var delegate: MoviewCoverCellDelegate?

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
        
        addSubview(dismissButton)
        dismissButton.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        dismissButton.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        dismissButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        dismissButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        dismissButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func dismissTapped() {
        
        if let localDelagate = delegate {
            localDelagate.didTapDismiss()
        }
    }

}
