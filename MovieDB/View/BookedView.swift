//
//  BookedView.swift
//  MovieDB
//
//  Created by Samarth Paboowal on 29/03/19.
//  Copyright © 2019 Samarth Paboowal. All rights reserved.
//

import UIKit

class BookedView: UIView {

    let tickImageView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "tick")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Your ticket has been booked"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        tickImageView.frame = CGRect(x: 35, y: 0, width: 180, height: 180)
        tickImageView.alpha = 0
        addSubview(tickImageView)
        
        messageLabel.frame = CGRect(x: 10, y: 180, width: 230, height: 50)
        messageLabel.alpha = 0
        addSubview(messageLabel)
    }

}
